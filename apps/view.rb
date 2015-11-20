#view.rb
require 'gosu'
require_relative 'shape'
require_relative 'winky'
require_relative 'background'

class View

  SCROLL_SENSITIVITY = 20

  def initialize(model,backgrounds)
    @model = model
    @cursor = Gosu::Image.new("../assets/cursor.bmp")
    @winky = Winky.new("../assets/winky.bmp")
    @backgrounds = backgrounds
    @y_offset = 0
  end

  def draw_hats
    @model.hats.each { |hat| hat.draw(hat == @model.selected_hat) if hat }
  end

  def draw_cursor(x,y)
    @cursor.draw(x,y,0)
  end

  def scroll_up
    @y_offset += SCROLL_SENSITIVITY
  end

  def scroll_down
    @y_offset -= SCROLL_SENSITIVITY
  end

  def change_background(dir,height)
    if dir == :up
      @y_offset+= height - (@y_offset % height)
    elsif dir == :down
      @y_offset-= (@y_offset % height) == 0 ? height : (@y_offset % height)
    end
  end

  def draw_background(width,height)
    index = ((@y_offset/height).floor % @backgrounds.length) * -1
    # puts "INDEX : #{ index } OFFSET : #{@y_offset}"
    (-1..1).each do |i|
      # puts "DRAWING #{index+i}  at #{@y_offset + i *height}"
        background(index+i).draw((@y_offset % height ) +i*height,width,height)
    end
    # @backgrounds[@model.current_background % @backgrounds.length].draw(width,height)
  end

  def background(index)
    @backgrounds[index.abs % @backgrounds.length]
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
