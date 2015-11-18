#hat.rb
require 'gosu'
class Hat
  attr_reader :x_pos, :y_pos

  def initialize(filepath,x,y)
    @image = Gosu::Image.new(filepath)
    @x_pos = x
    @y_pos = y
  end

  def draw
    @image.draw(@x_pos,@y_pos,0)
  end

  def move_to(x,y)
    @x_pos = x
    @y_pos = y
  end

  def on?(x,y)
    between?(x,@x_pos,@image.width)&&between?(y,@y_pos,@image.height)
  end

  private

  def between?(value,start,size)
    value >= start && value < start+size
  end

end
