#shape.rb
require 'gosu'

class Shape

  WHITE = Gosu::Color.argb(0xff_ffffff)

  def self.draw_rect(x1,y1,x2,y2,color)
    Gosu::draw_quad(x1,y1,color,x1,y2,color,x2,y2,color,x2,y1,color)
  end

  def self.draw_image_rect(x1,y1,x2,y2,image,color=WHITE)
    image.draw_as_quad(x2,y1,color,x1,y1,color,x1,y2,color,x2,y2,color,0)
  end

end
