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
  end

  def draw_hats
    @model.hats.each { |hat| hat.draw(hat == @model.selected_hat) if hat }
  end

  def draw_cursor(x,y)
    @cursor.draw(x,y,0)
  end

  def draw_background(width,height)
    @backgrounds[@model.current_background].draw(width,height)
  end

  def draw_winky(x,y)
    @winky.draw(x,y)
  end

  def save_background
    bg = @backgrounds[@model.current_background].type
    @model.hats.each { |hat| bg.insert(hat.image,hat.x_pos.to_i,hat.y_pos.to_i) if hat }
    bg.save("test.png")
  end

end
