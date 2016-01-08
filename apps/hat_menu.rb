require_relative 'menu'
class HatMenu < Menu
  MENU_COLOR = Gosu::Color.argb(0xff_e70061)
  MENU_EVEN_COLOR = Gosu::Color.argb(0xff_ED5A98)
  MENU_ODD_COLOR = Gosu::Color.argb(0xff_e92f7d)

  def select_menu_entry(x, y)
    row = ((y + @scroll_level) / (square_size)).floor
    col = (x - @box.x1) < square_size ? 0 : 1
    @entries[row * 2 + col]
  end

  def draw
    draw_menu
    draw_entries
  end

private

  def draw_menu
    Shape.draw_rect(@box.x1, 0, @box.x2, @box.y2, MENU_EVEN_COLOR)
  end

  def number_of_rows
    (@entries.length / @cols).ceil
  end

  def draw_entries
    @cols.times.with_index do |col|
      number_of_rows.times do |row|
        draw_entry(row, col)
      end
    end
  end

  def draw_entry(row, col)
    x = @box.x1 + col * square_size
    y = row * square_size - @scroll_level
    if entry = @entries[row * @cols + col]
      draw_menu_entry_background(x, y, square_size, entry_color(row, col))
      entry.draw(x, y, square_size)
    end
  end

  def entry_color(row,col)
     (col + row) % 2 == 0 ? MENU_EVEN_COLOR : MENU_ODD_COLOR
  end

  def draw_menu_entry_background(x, y, size, color)
      Shape.draw_rect(x, y, x + square_size, y + square_size, color)
  end
end
