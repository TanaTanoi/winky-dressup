#entry_loader.rb

require_relative 'menu_entry'

class EntryLoader

  ASSETS_PREFIX = "../assets/"

  def self.load_entries_from(filename)
    entry_list = File.read(filename).split
    entry_list.map do |img_file|
      MenuEntry.new(ASSETS_PREFIX+img_file)
    end
  end

  def self.load_backgrounds_from(filename)
    background_list = File.read(filename).split
    background_list.map! do |bg|
      bg.match(/^0x.._......$/)? Background.new(bg.to_i(16)) : Background.new(ASSETS_PREFIX+bg) 
    end
  end

end
