class BadgePdf < Prawn::Document
  def initialize(people, options = {})
    super()
    @people = people
    @options = options

    default_options
    generate_pdf
  end

  private

  attr_reader :people, :options

  WIDTH = 220
  HEIGHT = 347

  def default_options

  end

  def generate_pdf
    people.each_slice(4).with_index do |page, num|
      # Front Page
      start_new_page unless num == 0 # Don't create new page if first page.

      page.each_with_index do |person, i|
        create_badge(person, i) if person
      end

      draw_print_lines

      # Reverse Page
      start_new_page

      page.in_groups_of(2).reverse.each_with_index do |reverse_page, i|
        reverse_page.reverse.each_with_index do |person, j|
          # This calculates the correct order for badges 3 & 4
          if (i % 3 == 0)
            j += 2
          end
          create_badge(person, j) if person
        end
      end
    end
  end

  def draw_print_lines
    # line [x, y], [x, y]
    # Top
    line [bounds.left + 40, bounds.top + 25], [bounds.left + 40, bounds.top - 4] # Left
    line [bounds.width / 2, bounds.top + 25], [bounds.width / 2, bounds.top - 4] # Middle
    line [bounds.right - 40, bounds.top + 25], [bounds.right - 40, bounds.top - 4] # Right

    # Bottom
    line [bounds.left + 40, bounds.bottom + 4], [bounds.left + 40, bounds.bottom - 25] # Left
    line [bounds.width / 2, bounds.bottom + 4], [bounds.width / 2, bounds.bottom - 25] # Middle
    line [bounds.right - 40, bounds.bottom + 4], [bounds.right - 40, bounds.bottom - 25] # Right

    # Left
    line [bounds.left - 25, bounds.top - 4], [bounds.left + 40, bounds.top - 4] # Top
    line [bounds.left - 25, bounds.height / 2], [bounds.left + 40, bounds.height / 2] # Middle
    line [bounds.left - 25, bounds.bottom + 4], [bounds.left + 40, bounds.bottom + 4] # Bottom

    # Right
    line [bounds.right + 25, bounds.top - 4], [bounds.right - 40, bounds.top - 4] # Top
    line [bounds.right + 25, bounds.height / 2], [bounds.right - 40, bounds.height / 2] # Middle
    line [bounds.right + 25, bounds.bottom + 4], [bounds.right - 40, bounds.bottom + 4] # Top

    # Draw Lines
    stroke_color '7E7E7E'
    dash [2, 3, 0]
    line_width 1
    stroke # This actually draws the line
    undash
  end

  def create_badge(person, ord)
    badge_bounds = {
      1 => [bounds.left + 45, bounds.top - 8],
      2 => [bounds.right - WIDTH - 45, bounds.top - 8],
      3 => [bounds.left + 45, bounds.bottom + HEIGHT + 8],
      4 => [bounds.right - WIDTH - 45, bounds.bottom + HEIGHT + 8]
    }

    bounding_box(badge_bounds[ord+1], :width => WIDTH, :height => HEIGHT) do
      draw_logo

      # This is here instead of higher in the chain for blank tag generation
      options[:blanks] ? (move_down 100) : draw_name(person)

      text 'INTERESTS:', align: :center, size: 15, color: 'FF0000', style: :bold

      text 'SPEAKER', valign: :bottom, align: :center, size: 25, style: :bold

      stroke_color 'FF0000'
      line_width 10
      stroke_bounds
    end
  end

  def draw_logo
    move_down 5
    image Rails.root.join("app", "assets", "images", "logo.png"),
          position: :center,
          height: 50
    move_down 10
  end

  def draw_name(person)
    text person.first_name, align: :center, size: 34, style: :bold
    move_down 5
    text person.last_name, align: :center, size: 30, style: :bold
    move_down 15
  end

end
