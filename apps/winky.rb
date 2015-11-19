#winky.rb

class Winky

  require 'gosu'

  require_relative 'shape'

  SIZE = 100

  def initialize(filepath)
    @image = Gosu::Image.new(filepath)
  end

  def draw(center_x,center_y)
    # size = @image.width
    Shape.draw_image_rect(center_x-SIZE,center_y-SIZE,center_x+SIZE,center_y+SIZE,@image)
  end

end
