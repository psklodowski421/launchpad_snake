class DisplayHandler
  include Launchpad::Actions

  def initialize(device)
    @device = device
    @game_board_notes = Launchpad::NotesMapping.main_board_notes
  end

  def render(objects)
    objects.each do |object|
      # next if object.instance_of?(FreePlacesInfoGuy)

      object.render.each do |cord_hash|
        note, color, destroy = convert_cord(cord_hash)
        next light_off(note) if destroy

        light_on(1, note, color)
      end
    end
  end

  def convert_cord(cord_hash)
    destroy = cord_hash[:destroy] ? true : false
    [@game_board_notes[cord_hash[:x]][cord_hash[:y]],
     cord_hash[:color],
     destroy]
  end
end
