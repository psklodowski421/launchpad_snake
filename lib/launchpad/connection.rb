
module Launchpad
  class Connection
    def self.initialize_connection
      input = UniMIDI::Output.use(:first)
      output = UniMIDI::Output.use(:first)
      [input, output]
    end
  end
end
