#view.rb
require 'gosu'
require_relative 'shape'
require_relative 'winky'
require_relative 'background'

class View

  def initialize(model,backgrounds)
    @model = model
    @cursor = Gosu::Image.new("../assets/cursor.bmp")
    @winky = Winky.new("../assets/winky.bmp")
    @backgrounds = backgrounds
    @current_background = 0
  end

  def draw_hats
    @model.hats.each { |hat| hat.draw if hat }
  end

  def draw_cursor(x,y)
    @cursor.draw(x,y,0)
  end

  def draw_background(width,height)
    @backgrounds[@current_background].draw(width,height)
  end

  def draw_winky(x,y)
    @winky.draw(x,y)
  end


  def change_background(dir)
    @current_background = (@current_background+=dir).modulo(@backgrounds.length)
  end
end
