#interface.rb
require 'gosu'
require_relative 'hat'
require_relative 'view'
require_relative 'game'
require_relative 'menu'

class MyWindow < Gosu::Window

  MOUSE_1_ID = 256
  MOUSE_SCROLL_UP = 260
  MOUSE_SCROLL_DOWN = 259

  def initialize(model,view,fullscreen = false)
   super(640, 480, fullscreen)
   self.caption = 'Mr. Winky Dressup'
   @keys = Hash.new(false)
   @model = model
   @view = view
   @menu = Menu.new(self.width,self.height)
  end

  def update
    #updates the game state (called 60 times/s)
    if mouse_1_down?
      @model.move_selected_to(self.mouse_x,self.mouse_y)
    end
  end

  def draw
    #does the drawing (called after update)
    @view.draw_background(self.width,self.height)
    @menu.draw
    @view.draw_hats
    @view.draw_cursor(self.mouse_x,self.mouse_y)
  end

  def button_down(id)
    #For reference:
    #256     : MB1
    #258     : MB2
    #30 - 39 : 1 - 0
    # puts "DOWN : #{id}"
    @keys[id] = true
    #TODO refactor this stuff into another method
    @model.select_hat(self.mouse_x,self.mouse_y) if id == MOUSE_1_ID
    @menu.scroll_up if id == MOUSE_SCROLL_UP && @menu.on?(self.mouse_x,self.mouse_y)
    @menu.scroll_down if id == MOUSE_SCROLL_DOWN && @menu.on?(self.mouse_x,self.mouse_y)
  end

  def button_up(id)
    # puts "UP   : #{id}"
    @keys[id] = false
    @model.deselect_hat if id == MOUSE_1_ID

  end

  def mouse_1_down?
    @keys[MOUSE_1_ID]
  end

end
