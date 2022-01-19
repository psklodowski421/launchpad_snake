class AppleHandler

  def initialize
    @max_apples = 2
    @apples = []
    @i_know_about = []
  end

  def tick
    apple_ate?
    let_me_plant_apple if @apples.count < 1
    @i_know_about = []
  end

  def apple_ate?
    @apples.each do |apple|
      head_cords = snake_info[:my_cords].first
      remove_apple(apple) if apple.x == head_cords[:x] && apple.y == head_cords[:y]
    end
    snake_info[:my_cords].first
  end

  def remove_apple(apple)
    @apples.delete(apple)
  end

  def info_you_should_know_about_me
    @apples.map(&:info_you_should_know_about_me) if @apples.any?
  end

  def render
    @apples.map(&:render)
  end

  def let_me_plant_apple
    create_new_apple(place_to_seed_apple) if can_i_seed?
  end

  def create_new_apple(cords)
    begin
      @apples << Apple.new(cords[:x], cords[:y])
    rescue => e
      binding.pry
    end
  end

  def can_i_seed?
    place_to_seed_apple
  end

  def place_to_seed_apple
    free_places = @i_know_about.detect { |obj| obj[:class] == FreePlacesInfoGuy }[:free_places]
    free_places.sample
  end

  def snake_info
    @i_know_about.detect { |object| object[:class] == Snake }
  end

  def i_know_about(obj)
    @i_know_about << obj
  end
end
