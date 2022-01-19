# frozen_string_literal: true

module Launchpad
  module Actions
    # Signals informations
    # Normal buttons
    # 144 Light
    # 145 Fliping On/Off
    # 146 Fading

    # Top Lights
    # 176 Light
    # 177 Fliping On/Off
    # 178 Fading
    #
    def light_on(mode, note, color = 4)
      color = 0 if mode == 4
      mapped_trigger = map_mode(mode, note)
      @device.output.puts(mapped_trigger, note, color)
    end

    def light_off(note)
      signal = top_button?(note) ? 176 : 144
      @device.output.puts(signal, note, 0)
    end

    def light_on_board(color = 6)
      Launchpad::NotesMapping.main_board_notes.flatten.each { |el| light_on(1, el, color) }
    end

    def light_off_board
      Launchpad::NotesMapping.main_board_notes.flatten.each { |el| light_off(el) }
      Launchpad::NotesMapping.top_control_notes.flatten.each { |el| light_off(el) }
      Launchpad::NotesMapping.right_control_notes.flatten.each { |el| light_off(el) }
    end

    private

    def top_button?(note)
      note > 100
    end

    def map_mode(mode, note)
      case mode
      # Light
      when 1
        (11..89).include?(note) ? 144 : 176
      # Flipping On/Off
      when 2
        (11..89).include?(note) ? 145 : 177
      # Fading
      when 3
        (11..89).include?(note) ? 146 : 178
      end
    end
  end
end
