require 'gosu'
require_relative 'hat'
require_relative 'view'
require_relative 'game'
require_relative 'hat_menu'
require_relative 'background_menu'
require_relative 'bounding_box'

class MyWindow < Gosu::Window
  MOUSE_1_ID = 256
  MOUSE_SCROLL_DOWN = 260
  MOUSE_SCROLL_UP = 259
  UP_ARROW_KEY = 82
  DOWN_ARROW_KEY = 81
  SPACE_BAR = 44

  HAT_MENU_RATIO = 0.3

  def initialize(model, view, backgrounds, fullscreen = false)
   super(820, 640, fullscreen)
   self.caption = 'Mr. Winky Dress up'
   @keys = Hash.new(false)
   @model = model
   @view = view
   @hat_menu = hat_menu_setup
   @background_menu = background_menu_setup(backgrounds)
  end

  def hat_menu_setup
    hat_menu_width = self.width * HAT_MENU_RATIO
    hat_menu_bounding_box = BoundingBox.new(self.width-hat_menu_width, 0, self.width, self.height)
    HatMenu.new(hat_menu_bounding_box, @model.entries, 2)
  end

  def background_menu_setup(backgrounds)
    background_menu_width = self.width - @hat_menu.box.width
    background_menu_bounding_box = BoundingBox.new(0, 0, background_menu_width, self.height)
    BackgroundMenu.new(background_menu_bounding_box, backgrounds, 1)
  end

  def update
    #updates the game state (called 60 times/s)
    if mouse_1_down?
      @model.move_selected_to(self.mouse_x, self.mouse_y)
    end
  end

  def draw
    #does the drawing (called after update)
    #@view.draw_background(self.width*(1-Menu::WINDOW_SIZE_RATIO),self.height)

    @background_menu.draw
    @view.draw_winky(draw_center[0], draw_center[1])
    @hat_menu.draw
    @view.draw_hats
    @view.draw_cursor(self.mouse_x, self.mouse_y)
  end

  def draw_center
    [ (self.width - @hat_menu.box.width) / 2, self.height / 2 ]
  end

  def button_down(id)
    @keys[id] = true
    click(id, self.mouse_x, self.mouse_y)

  end

  def click(button, x, y)
    case button
    when MOUSE_1_ID
      if @model.select_hat(x, y) == nil
        add_from_menu(x, y) if @hat_menu.on?(x, y)
      end
    when MOUSE_SCROLL_UP
      if @hat_menu.on?(x, y)
        @hat_menu.scroll_up
      else
        @background_menu.scroll_up
      end
    when MOUSE_SCROLL_DOWN
      if @hat_menu.on?(x, y)
        @hat_menu.scroll_down
      else
        @background_menu.scroll_down
      end
    when UP_ARROW_KEY
      @background_menu.background_set_next
    when DOWN_ARROW_KEY
      @background_menu.background_set_previous
    when SPACE_BAR
      @model.remove_all_hats
    else
      puts button
      # @view.save_background
    end

  end

  def add_from_menu(x, y)
    entry = @hat_menu.select_menu_entry(x, y)
    @model.add_and_select(entry.filepath, x, y) if entry
  end

  def button_up(id)
    @keys[id] = false
    if id == MOUSE_1_ID
        if @hat_menu.on?(self.mouse_x, self.mouse_y)
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
