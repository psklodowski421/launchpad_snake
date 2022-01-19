class GameStateHandler
  def initialize
    @i_know_about = []
    @state = 'pending'
  end

  def info_you_should_know_about_me
    { class: self.class, state: @state }
  end

  def detect_current_state
    return @state = 'win' if snake_info[:my_cords].count == 64

    snake_head_cords = snake_info[:my_cords].shift
    snake_body_cords = snake_info[:my_cords]
    snake_body_cords.each do |part_cords|
      return @state = 'game_over' if part_cords[:x] == snake_head_cords[:x] && part_cords[:y] == snake_head_cords[:y] && !part_cords[:destroy]
    end
  end

  def i_know_about(obj)
    @i_know_about << obj
  end

  def snake_info
    @i_know_about.detect { |object| object[:class] == Snake }
  end

  def render
    []
  end

  def tick
    detect_current_state
    @i_know_about = []
  end
end
