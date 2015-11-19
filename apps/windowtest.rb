require 'gosu'
require_relative 'interface'

model = Game.new(EntryLoader.load_entries_from("asset_list.txt"))
view = View.new(model)
window = MyWindow.new(model,view)
window.show
