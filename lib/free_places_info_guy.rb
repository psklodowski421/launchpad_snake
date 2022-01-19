class FreePlacesInfoGuy
  def initialize
    @i_know_about = []
    @free_places_board = free_places_board
  end

  def info_you_should_know_about_me
    { class: self.class, free_places: let_me_calculate_free_places }
  end

  def i_know_about(obj)
    @i_know_about << obj
  end

  def let_me_calculate_free_places
    taken_cords = @i_know_about.flatten.map do |obj|
      obj[:my_cords]
    end.flatten.compact
    current_free_places_board = free_places_board
    taken_cords.each do |taken_cord|
      current_free_places_board.reject! { |el| el[:x] == taken_cord[:x] && el[:y] == taken_cord[:y] }
    end
    current_free_places_board
  end

  def free_places_board
    board = []
    (0..7).to_a.map do |x|
      second_cord = 0
      8.times do
        board << { x: x, y: second_cord }
        second_cord += 1
      end
    end
    board
  end

  def render
    []
  end

  def tick
    @i_know_about = []
  end
end
