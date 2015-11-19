#view.rb
require 'gosu'
require_relative 'shape'
class View

  def initialize(model)
    @model = model
    @cursor = Gosu::Image.new("../assets/cursor.gif")
  end

  def draw_hats
    @model.hats.each { |hat| hat.draw }
  end


  def draw_cursor(x,y)
    @cursor.draw(x,y,0)
  end

  def draw_background(width,height)
    white = Gosu::Color.argb(0xff_ffffff)
    Shape.draw_rect(0,0,width,height,white)
  end
end
