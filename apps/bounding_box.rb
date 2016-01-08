class BoundingBox
  attr_reader :x1, :y1, :x2, :y2

  def initialize(x1, y1, x2, y2)
    @x1, @y1, @x2, @y2 = x1, y1, x2, y2
  end

  def width
    x2 - x1
  end

  def height
    y2 - y1
  end

  def on?(x, y)
    x >= @x1 && x < @x2 && y >= @y1 && y < @y2
  end
end
