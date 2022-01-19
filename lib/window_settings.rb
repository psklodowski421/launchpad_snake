# frozen_string_literal: true

# Settings for window
class WindowSettings < Window
  def self.call
    set title: 'Launchpad Multi Tool',
        width: 400,
        height: 400,
        resizable: false,
        background: 'red'
  end

  def self.set_background
    set background: 'purple'
  end
end
