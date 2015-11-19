#background.rb
require 'gosu'
require_relative 'shape'

class Background

  attr_reader :type
  def initialize(arg)
    puts arg
    if arg.is_a? String
      @type = Gosu::Image.new(arg)
      @draw_type = :draw_image
    elsif arg.is_a? Fixnum
      @type = Gosu::Color.argb(arg)
      @draw_type = :draw_color
    else
      puts "ERROR Cannot accept type #{arg.class} : #{arg.type} "
      fail
    end

  end

  def draw(width,height)
    send(@draw_type,width,height)
  end

  def draw_image(width,height)
    Shape.draw_image_rect(0,0,width,height,@type)
  end

  def draw_color(width,height)
    Shape.draw_rect(0,0,width,height,@type)
  end

end
