#game.rb
require 'gosu'
require_relative 'hat'
require_relative 'entry_loader'

class Game
  attr_reader :hats, :entries, :selected_hat, :current_background

  def initialize(entries)
    @hats = []
    @selected_hat = nil
    @offset = [0,0]
    @entries =entries
    @current_background = 0
  end

  def move_selected_to(x,y)
    @selected_hat.move_to(x-@offset[0],y-@offset[1]) if @selected_hat
  end

  def add_and_select(filepath,x,y)
    @selected_hat = Hat.new(filepath,x,y)
    @hats.push(@selected_hat)
    calculate_offset(x+@selected_hat.width/2,y+@selected_hat.width/2)
  end

  def remove_selected
    @hats.delete(@selected_hat)
    deselect_hat
  end

  def remove_all_hats
    @hats.clear
  end

  def deselect_hat
    @selected_hat = nil
  end

  def select_hat(x,y)
    @selected_hat =
    @hats.select do |hat|
      hat.on?(x,y) if hat
    end.last
    calculate_offset(x,y)
    move_to_front(@selected_hat)
  end

  private

  def move_to_front(hat)
    @hats.delete(hat)
    @hats.push(hat).last
  end

  def calculate_offset(mx,my)
    @offset = [mx-@selected_hat.x_pos,my-@selected_hat.y_pos] if @selected_hat
  end

end
