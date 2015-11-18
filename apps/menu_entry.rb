#menu_entry.rb

class MenuEntry

  attr_reader :x_pos, :y_pos
  attr_accessor :color
  def initialize(filepath)
    @image = Gosu::Image.new(filepath)
    @color = Shape::WHITE
  end

  def draw(x,y,square_size)
    Shape.draw_image_rect(x,y,x+square_size,y+square_size,@color,@image)
  end

  private

  def between?(value,start,size)
    value >= start && value < start+size
  end


end
