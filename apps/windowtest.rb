require 'gosu'
require_relative 'interface'

model = Game.new
view = View.new(model)
window = MyWindow.new(model,view)
window.show
