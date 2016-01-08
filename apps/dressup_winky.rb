require_relative 'interface'
loader = EntryLoader.new("asset_list_small.txt", "background_list.txt")

model = Game.new(loader.load_hats)
view = View.new(model)
window = MyWindow.new(model, view, loader.load_backgrounds, ARGV[0])
window.show
