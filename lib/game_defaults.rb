module GameDefaults
  def initializers
    @tick = 0
    WindowSettings.call
    @device = Launchpad::Device.new
    @objects = []
    @snake = Snake.new
    @objects << @snake
    @apple_handler = AppleHandler.new
    @objects << @apple_handler
    @free_places_info_guy = FreePlacesInfoGuy.new
    @objects << @free_places_info_guy
    @game_state_handler = GameStateHandler.new
    @objects << @game_state_handler
    @things_brain = ThingsBrain.new(@objects)
    @display_handler = DisplayHandler.new(@device)
  end
end
