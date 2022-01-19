# Hey I'm apple, I'am made to be eaten by snake
class Apple
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    @age = 0
    @color = 30
  end

  def info_you_should_know_about_me
    { class: self.class, my_cords: { x: @x, y: @y, age: @age, color: @color } }
  end

  def render
    { x: @x, y: @y, age: @age, color: @color }
  end

  def tick
    @age += 1
  end
end
