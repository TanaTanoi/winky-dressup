require 'gosu'
require_relative 'interface'

model = Game.new(EntryLoader.load_entries_from("asset_list.txt"))
view = View.new(model,EntryLoader.load_backgrounds_from("background_list.txt"))
window = MyWindow.new(model,view)
window.show
