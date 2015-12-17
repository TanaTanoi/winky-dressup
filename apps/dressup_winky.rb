#dressup_winky.rb
#args : bool=>fullscreen

require_relative 'interface'

model = Game.new(EntryLoader.load_entries_from("asset_list.txt"))
view = View.new(model,)
backgrounds = EntryLoader.load_backgrounds_from("background_list.txt")
window = MyWindow.new(model,view,backgrounds,ARGV[0])
window.show
