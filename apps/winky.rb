require 'gosu'
require_relative 'shape'

class Winky
  attr_reader :image

  SIZE = 100

  def initialize(filepath)
    @image = Gosu::Image.new(filepath)
  end

  def draw(center_x, center_y)
    Shape.draw_image_rect(center_x - SIZE, center_y - SIZE, center_x + SIZE, center_y + SIZE, @image)
  end

end
