class BadgePdf < Prawn::Document
  def initialize(people, options = nil)
    super()
    @people = people
    @options = options

    generate_pdf
  end

  private

  attr_reader :people, :options


  WIDTH = 220
  HEIGHT = 347


  def generate_pdf
    people.each_slice(4).with_index do |page, num|
      start_new_page unless num == 0

      # Front Page
      page.each_with_index do |person, i|
        create_badge(person, i)
      end
      start_new_page

      # Reverse Page
      page.reverse.in_groups_of(2).reverse.each_with_index do |reverse_page, i|
        reverse_page.each_with_index do |person, j|
          if i % 2 == 1
            j += 2
          end
          create_badge(person, j)
        end
      end
    end
  end

  def create_badge(person, ord)
    badge_bounds = {
      1 => [bounds.left + 47, bounds.top - 10],
      2 => [bounds.right - WIDTH - 47, bounds.top - 10],
      3 => [bounds.left + 47, bounds.bottom + HEIGHT + 10],
      4 => [bounds.right - WIDTH - 47, bounds.bottom + HEIGHT + 10]
    }

    bounding_box(badge_bounds[ord+1], :width => WIDTH, :height => HEIGHT) do
     draw_logo

     draw_name(person)

     text 'INTERESTS:', align: :center, size: 15, color: 'FF0000', style: :bold

     text 'SPEAKER', valign: :bottom, align: :center, size: 25, style: :bold

     stroke_color 'FF0000'
     line_width 5
     stroke_bounds
    end
  end

  def draw_logo
    image Rails.root.join("app", "assets", "images", "logo.png"),
          position: :center,
          height: 50
    move_down 20
  end

  def draw_name(person)
     text person.first_name.titleize, align: :center, size: 40, style: :bold
     move_down 5
     text person.last_name.titleize, align: :center, size: 30, style: :bold
     move_down 15
  end

end
