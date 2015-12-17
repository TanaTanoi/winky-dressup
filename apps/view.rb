#view.rb
require 'gosu'
require_relative 'shape'
require_relative 'winky'

class View
  SCROLL_SENSITIVITY = 20

  def initialize(model)
    @model = model
    @cursor = Gosu::Image.new("../assets/cursor.bmp")
    @winky = Winky.new("../assets/winky.bmp")
    @y_offset = 0
  end

  def draw_hats
    @model.hats.each { |hat| hat.draw(hat == @model.selected_hat) if hat }
  end

  def draw_cursor(x,y)
    @cursor.draw(x,y,0)
  end

  def draw_winky(x,y)
    @winky.draw(x,y)
  end
end
