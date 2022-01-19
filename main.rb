# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require
loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/lib")
loader.enable_reloading # you need to opt-in before setup
loader.setup
loader.eager_load

game = Game.new

on :key_down do |event|
  # A key was pressed
  case event.key
  when 'escape'
    game.light_off_board
    sleep 1
    close
  when 'up'
    game.change_snake_dir('up')
  when 'down'
    game.change_snake_dir('down')
  when 'right'
    game.change_snake_dir('right')
  when 'left'
    game.change_snake_dir('left')
  end
  puts event.key
end

update do
  game.main_process
end

show
