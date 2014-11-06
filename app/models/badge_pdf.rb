class BadgePdf < Prawn::Document
  def initialize(event, options = {})
    super()
    @options = options
    @event = event

    if options[:blanks]
      @role = options[:role]
    else
      @roles = @event.roles
    end

    default_options
    generate_pdf
  end

  private

  attr_reader :event, :roles, :options

  WIDTH = 220
  HEIGHT = 347

  def default_options
    options[:color] = '000000'
    options[:padding] = 50
  end

  def set_options(role)
    # if options[:role]
    #   @role = event.find(options[:role])
    #   options[:color] = @role.border_color
    #   options[:padding] = @role.name_location
    # end
    if role.border_color
      options[:color] = role.border_color
    end
    if role.name_location
      options[:padding] = role.name_location
    end
  end

  def generate_pdf
    if options[:blanks] & options[:num_badges]
      set_options(@role)
      options[:num_badges].times.each_slice(4).with_index do |page, num|
        generate_page(page, num)
      end

    elsif @role
      set_options(@role)

      @role.people.order(last_name: :asc, first_name: :asc).each_slice(4).with_index do |page, num|
        start_new_page unless page == 0

        generate_page(page, num)
      end
    else
      roles.each do |role|
        set_options(role)
        draw_cover_page(role)

        role.people.order(last_name: :asc, first_name: :asc).each_slice(4).with_index do |page, num|
          generate_page(page, num)

          start_new_page unless page == 0
        end
      end
    end
  end

  def draw_cover_page(role)
    text role.level, size: 35, align: :center
    text "Role Display: #{role.display.upcase}", size: 25, align: :center
    move_down 100

    text "People in this role: #{role.people.count.to_s}", size: 20, align: :center
    start_new_page
  end

  def generate_page(page, num)
    # Front Page
    page.each_with_index do |person, i|
      create_badge(person, i) if person
    end

    draw_print_lines

    # Reverse Page
    start_new_page

    page.in_groups_of(2).each_with_index do |reverse_page, i|
      reverse_page.reverse.each_with_index do |person, j|
        # This calculates the correct order for badges 3 & 4
        if (i % 3 == 1)
          j += 2
        end

        create_badge(person, j) if person
      end
    end
  end

  def draw_print_lines
    # line [x, y], [x, y]
    # Top
    line [bounds.left + 40, bounds.top + 30], [bounds.left + 40, bounds.top - 4] # Left
    line [bounds.width / 2, bounds.top + 30], [bounds.width / 2, bounds.top - 4] # Middle
    line [bounds.right - 40, bounds.top + 30], [bounds.right - 40, bounds.top - 4] # Right

    # Bottom
    line [bounds.left + 40, bounds.bottom + 4], [bounds.left + 40, bounds.bottom - 30] # Left
    line [bounds.width / 2, bounds.bottom + 4], [bounds.width / 2, bounds.bottom - 30] # Middle
    line [bounds.right - 40, bounds.bottom + 4], [bounds.right - 40, bounds.bottom - 30] # Right

    # Left
    line [bounds.left - 30, bounds.top - 4], [bounds.left + 40, bounds.top - 4] # Top
    line [bounds.left - 30, bounds.height / 2], [bounds.left + 40, bounds.height / 2] # Middle
    line [bounds.left - 30, bounds.bottom + 4], [bounds.left + 40, bounds.bottom + 4] # Bottom

    # Right
    line [bounds.right + 30, bounds.top - 4], [bounds.right - 40, bounds.top - 4] # Top
    line [bounds.right + 30, bounds.height / 2], [bounds.right - 40, bounds.height / 2] # Middle
    line [bounds.right + 30, bounds.bottom + 4], [bounds.right - 40, bounds.bottom + 4] # Top

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

      # text 'INTERESTS:', align: :center, size: 15, color: 'FF0000', style: :bold

      if options[:blanks]
        text @role.display.upcase, valign: :bottom, align: :center, size: 25, style: :bold
      else
        text person.role.display.upcase, valign: :bottom, align: :center, size: 25, style: :bold
      end
      stroke_color options[:color]
      line_width 10
      stroke_bounds
    end
  end

  def draw_logo
    move_down 5
    image @event.logo_fullpath,
          position: :center,
          height: 50
    move_down 10
  end

  def draw_name(person)
    # text options[:padding], align: :center
    move_down options[:padding]
    text person.first_name, align: :center, size: 34, style: :bold
    move_down 5
    text person.last_name, align: :center, size: 30, style: :bold
    move_down 15
  end

end
