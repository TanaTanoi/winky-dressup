#hat.rb
require 'gosu'
require_relative 'shape'
class Hat
  attr_reader :x_pos, :y_pos
  SIZE  = 200
  def initialize(filepath,x,y)
    @image = Gosu::Image.new(filepath)
    @x_pos = x
    @y_pos = y
  end

  def draw
    Shape.draw_image_rect(@x_pos,@y_pos,@x_pos+SIZE,@y_pos+SIZE,@image)
    # @image.draw(@x_pos,@y_pos,0)
  end

  def width
    # @image.width
    SIZE
  end

  def move_to(x,y)
    @x_pos = x
    @y_pos = y
  end

  def on?(x,y)
    between?(x,@x_pos,width)&&between?(y,@y_pos,width)
  end

  private

  def between?(value,start,size)
    value >= start && value < start+size
  end

end
