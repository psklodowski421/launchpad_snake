class Snake
  attr_reader :head_position

  def initialize
    @body_color = 2
    @dir = 'right'
    @part_to_remove = nil
    @head_position = starting_head_position
    @body_position = starting_body_position
    @i_know_about = []
  end

  def i_know_about(obj)
    @i_know_about << obj
  end

  def starting_head_position
    { x: 3, y: 4, color: 10 }
  end

  def starting_body_position
    [{ x: 3, y: 3, color: @body_color },
     { x: 3, y: 2, color: @body_color }]
  end

  def change_dir(dir)
    old_dir = @dir.clone
    @dir = dir
    possible_point = @head_position.clone
    new_potential_position = move_part(possible_point, dir)
    valid_position(new_potential_position) ? @dir = old_dir : nil
  end

  def valid_position(potential_position)
    potential_position[:x] == @body_position.first[:x] && potential_position[:y] == @body_position.first[:y]
  end

  def move_part(hash, dir)
    case dir
    when 'up'
      update_cord_position(hash, :x, 'down')
    when 'down'
      update_cord_position(hash, :x, 'up')
    when 'right'
      update_cord_position(hash, :y, 'up')
    when 'left'
      update_cord_position(hash, :y, 'down')
    end
  end

  def update_cord_position(hash, cord, way)
    case way
    when 'up'
      hash[cord] = cord_up(hash[cord])
    when 'down'
      hash[cord] = cord_down(hash[cord])
    end
    hash
  end

  def cord_up(cord)
    case cord
    when 7
      0
    else
      cord + 1
    end
  end

  def cord_down(cord)
    case cord
    when 0
      7
    else
      cord - 1
    end
  end

  def im_on_apple?
    question = false
    apple_cords = @i_know_about.flatten.select { |obj| obj[:class] == Apple }.map { |e| e[:my_cords] }
    apple_cords.each do |apple_cord|
      question = true if apple_cord[:x] == @head_position[:x] && apple_cord[:y] == @head_position[:y]
    end
    question
  end

  def snake_crashed
    @head_position[:color]
  end

  def handle_game_state_change
    case game_state_handler[:state]
    when 'win'
      win_handling
    when 'game_over'
      game_over_handling
    end
  end

  def game_over_handling
    @head_position[:color] = 50
    hit_body_part = @body_position.detect { |el| el[:x] == @head_position[:x] && el[:y] == @head_position[:y] }
    hit_body_part[:color] = 50
  end

  def win_handling
    @head_position[:color] = 70
    @body_position.each do |body_part|
      body_part[:color] = 73
    end
  end

  def tick
    return handle_game_state_change if game_state_handler[:state] != 'pending'

    old_head_position = @head_position.clone
    old_head_position[:color] = @body_color
    # move head
    move_part(@head_position, @dir)

    @body_position.unshift(old_head_position)
    # handle apple eating
    unless im_on_apple?
      @part_to_remove = @body_position.pop
      @part_to_remove[:destroy] = true
    end
    @i_know_about = []
  end

  def info_you_should_know_about_me
    { class: self.class, my_cords: [@head_position, @body_position].flatten }
  end

  def game_state_handler
    @i_know_about.flatten.detect { |object| object[:class] == GameStateHandler }
  end

  def render
    render_array = []
    render_array << @head_position
    render_array << @body_position
    render_array.unshift @part_to_remove
    render_array.flatten
  end
end
