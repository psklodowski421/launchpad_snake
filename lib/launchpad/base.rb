module Launchpad
  module Base
    def self.included(klass)
      klass.class_eval do
        include Actions
      end
    end
  end
end
