#game.rb
require 'gosu'
require_relative 'hat'
require_relative 'entry_loader'

class Game
  attr_reader :hats, :entries

  def initialize(entry_filepath)
    @hats = []
    @hats.push(Hat.new("../assets/winky.jpg",0,0))
    @selected_hat = nil
    @offset = []
    @entries = EntryLoader.load_entries_from(entry_filepath)
  end

  def move_selected_to(x,y)
    @selected_hat.move_to(x-@offset[0],y-@offset[1]) if @selected_hat
  end

  def add_and_select(filepath,x,y)
    @selected_hat = Hat.new(filepath,x,y)
    @hats.push(@selected_hat)
  end

  def deselect_hat
    @selected_hat = nil
  end

  def select_hat(x,y)
    @selected_hat =
    @hats.select do |hat|
      hat.on?(x,y)
    end.last
    calculate_offset(x,y)
  end

  private

  def calculate_offset(mx,my)
    @offset = [mx-@selected_hat.x_pos,my-@selected_hat.y_pos] if @selected_hat
  end

end
