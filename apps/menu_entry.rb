#menu_entry.rb

class MenuEntry

  attr_reader :filepath
  def initialize(filepath)
    @filepath = filepath
    @image = Gosu::Image.new(filepath)
  end

  def draw(x,y,square_size)
    Shape.draw_image_rect(x,y,x+square_size,y+square_size,Shape::WHITE,@image)
  end

end
