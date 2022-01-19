class Game
  include Launchpad::Base
  include GameDefaults

  def initialize
    initializers
    light_off_board
  end

  def main_process
    if (@tick % 10).zero?
      # logic handler
      @things_brain.tell_all_about_all
      @objects.each(&:tick)
      # display handler
      @display_handler.render(@objects)
    end
    @tick += 1
  end

  def change_snake_dir(dir)
    @snake.change_dir(dir)
  end
end
