#interface.rb
require 'gosu'
require_relative 'hat'
require_relative 'view'
require_relative 'game'
require_relative 'menu'

class MyWindow < Gosu::Window

  MOUSE_1_ID = 256
  MOUSE_SCROLL_DOWN = 260
  MOUSE_SCROLL_UP = 259

  def initialize(model,view,fullscreen = false)
   super(640, 480, fullscreen)
   self.caption = 'Mr. Winky Dressup'
   @keys = Hash.new(false)
   @model = model
   @view = view
   @menu = Menu.new(self.width,self.height,@model)
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
    @keys[id] = true
    click(id,self.mouse_x,self.mouse_y)
  end

  def click(button,x,y)
    case button
    when MOUSE_1_ID
      if @model.select_hat(x,y) == nil
        add_from_menu(x,y) if @menu.on?(x,y)
      end
    when MOUSE_SCROLL_UP
      if @menu.on?(x,y)
        @menu.scroll_up
      end
    when MOUSE_SCROLL_DOWN
      if @menu.on?(x,y)
        @menu.scroll_down
      end
    else
      puts button
    end

  end

  def add_from_menu(x,y)
    entry = @menu.select_menu_entry(x,y)
    @model.add_and_select(entry.filepath,x,y)
  end

  def button_up(id)
    @keys[id] = false
    if id == MOUSE_1_ID
        if @menu.on?(self.mouse_x,self.mouse_y)
          @model.remove_selected
        else
          @model.deselect_hat
        end
      end

  end

  def mouse_1_down?
    @keys[MOUSE_1_ID]
  end

end
