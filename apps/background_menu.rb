#background_menu.rb
require_relative 'background'
require_relative 'menu'
class BackgroundMenu < Menu
    def draw
      draw_backgrounds
    end

    # def ensure_scroll_level
    #   if @scroll_level.abs > @entries.length * square_size
    #     @scroll_level *=-1
    #   end
    # end

    def square_size
      @box.height
    end

    def background_set_next
        @scroll_level+= @box.height - (@scroll_level % @box.height)
    end

    def background_set_previous
        @scroll_level-= (@scroll_level % @box.height) == 0 ? @box.height : (@scroll_level % @box.height)
    end

    private

    def draw_backgrounds
      index = ((@scroll_level/@box.height).floor % @entries.length)
      (-1..1).each do |i|
          draw_background(index + i,@box.width,@box.height)
      end
    end

    def draw_background(index,width,height)
      puts "Scroll level #{@scroll_level} other : #{height -(@scroll_level % height )}"
      background(index).draw(height - (@scroll_level % height ),width,height)
    end

    def background(index)
      @entries[index.abs % @entries.length]
    end
end
