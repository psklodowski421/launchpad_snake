module Launchpad
  class Device
    attr_reader :model, :input, :output

    def initialize
      @input, @output = Launchpad::Connection.initialize_connection
      @model = detect_device
    end

    def detect_device
      case @output.name
      when /MK2/
        'launchpad_mk2'
      end
    end

    def self.board_size_by_index
      7
    end
  end
end
