#hat_menu.rb

require 'gosu'
require_relative 'shape'
require_relative 'menu_entry'

class HatMenu < Menu

  COLS = 2
  WINDOW_SIZE_RATIO = 0.3
  MENU_COLOR = Gosu::Color.argb(0xff_e70061)
  MENU_EVEN_COLOR = Gosu::Color.argb(0xff_ED5A98)
  MENU_ODD_COLOR = Gosu::Color.argb(0xff_e92f7d)

  def initialize(window_width,window_height,model)
    @width = window_width*WINDOW_SIZE_RATIO
    @height = window_height
    @x_start = window_width - @width
    @y_menu_offset = 0
    @model = model
  end

  def select_menu_entry(x,y)
    row = ((y+@y_menu_offset)/(square_size)).floor
    col = (x-@x_start) < square_size ? 0 : 1
    @model.entries[row*2+col]
  end

  def draw
    draw_menu
    draw_entries
  end

private

  def draw_menu
    Shape.draw_rect(@x_start,0,@x_start+@width,@height,MENU_COLOR)
  end

  def draw_entries
    number_of_rows =(@model.entries.length/2.0).ceil
    COLS.times.with_index do |col|
      number_of_rows.times do |row|
        draw_entry(row,col)
      end
    end
  end

  def draw_entry(row,col)
    x = @x_start + col * square_size
    y = row * square_size - @y_menu_offset
    if entry = @model.entries[row*2+col]
      draw_menu_entry_background(x,y,square_size,entry_color(row,col))
      entry.draw(x,y,square_size)
    end
  end

  def entry_color(row,col)
     (col+row) % 2 == 0 ? MENU_EVEN_COLOR : MENU_ODD_COLOR
  end

  def draw_menu_entry_background(x,y,size,color)
      Shape.draw_rect(x,y,x+square_size,y+square_size,color)
  end
end
