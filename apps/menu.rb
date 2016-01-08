class Menu
  attr_reader :box

  SCROLL_SENSITIVITY = 20
  WHITE  = Gosu::Color.argb(0xff_ffffff)

  def initialize(bounding_box, entries, cols)
    @box = bounding_box
    @entries = entries
    @scroll_level = 0
    @cols = cols
  end

  def scroll_up
    @scroll_level += SCROLL_SENSITIVITY
    ensure_scroll_level
  end

  def scroll_down
    @scroll_level -= SCROLL_SENSITIVITY
    ensure_scroll_level
  end

  def square_size
    @box.width / @cols
  end

  def max_scroll
    ((@entries.size / @cols) - max_entries_on_screen / @cols) * square_size
  end

  def max_entries_on_screen
    (@box.height / square_size).floor
  end

  def draw
    Shape.draw_rect(@box.x1, 0, @box.x2, @box.y2, WHITE)
  end

  def ensure_scroll_level
    @scroll_level = [0, @scroll_level, max_scroll].sort[1]
  end

  def on?(x, y)
    @box.on?(x, y)
  end
end
