#menu.rb

require 'gosu'
require_relative 'shape'
require_relative 'menu_entry'

class Menu
  COLS = 2
  WINDOW_SIZE_RATIO = 0.3
  MENU_COLOR = Gosu::Color.argb(0xff_ffaaaa)
  SCROLL_SENSITIVITY = 18
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
    puts "ROW :#{row} COL #{col}"
    @model.entries[row*2+col]
  end

  def on?(x,y)
    x >= @x_start
  end

  def draw
    draw_menu
    draw_entries
  end

  def scroll_up
    @y_menu_offset = [0,@y_menu_offset-SCROLL_SENSITIVITY].max
  end

  def scroll_down
    @y_menu_offset = [10000,@y_menu_offset+SCROLL_SENSITIVITY].min
  end

  private

  def square_size
    @width/2
  end

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
    entry = @model.entries[row*2+col]
    if entry
      entry.draw(x,y,square_size)
    end
  end

end
