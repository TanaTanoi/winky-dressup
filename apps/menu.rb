#menu.rb

require 'gosu'
require_relative 'shape'
require_relative 'menu_entry'
class Menu
  COLS = 2
  WINDOW_SIZE_RATIO = 0.3
  MENU_COLOR = Gosu::Color.argb(0xff_ffaaaa)
  SCROLL_SENSITIVITY = 18
  def initialize(window_width,window_height)
    @width = window_width*WINDOW_SIZE_RATIO
    @height = window_height
    @x_start = window_width - @width
    @entries = []
    add_fake_entries
    @y_menu_offset = 0
  end

  def select_menu_entry(x,y)
    row = ((y+@y_menu_offset)/(square_size)).floor
    col = (x-@x_start) < square_size ? 0 : 1
    puts "ROW :#{row} COL #{col}"
    @entries[row*2+col]
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

  def add_fake_entries #TODO remove me
    20.times { @entries.push(MenuEntry.new("../assets/winky.jpg")) }
  end

  def draw_menu
    Shape.draw_rect(@x_start,0,@x_start+@width,@height,MENU_COLOR)
  end

  def draw_entries
    number_of_rows = (@height/square_size).round
    COLS.times.with_index do |col|
      (@entries.length/2).times do |row|


        x = @x_start + col * square_size
        y = row * square_size - @y_menu_offset
        @entries[row*2+col].draw(x,y,square_size)
        # color = Gosu::Color.argb(0xff_ff00ff*((col+row).modulo(2)))
        # Shape.draw_rect(x,y,x + square_size,y + square_size,color)

      end
    end

  end

end
