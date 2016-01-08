require_relative 'menu_entry'
require_relative 'background'

class EntryLoader
  DEFAULT_ASSET_PATH = "../assets/"

  def initialize(hat_path, background_path, asset_path: DEFAULT_ASSET_PATH)
    @asset_path = asset_path
    @hat_path = hat_path
    @background_path = background_path
  end

  def load_hats
    puts "Loading Menu Entries from #{@hat_path}..."

    entry_list = File.read(@hat_path).split
    entry_list.map do |img_file|
      MenuEntry.new(@asset_path + img_file)
    end
  end

  def load_backgrounds
    puts "Loading background images from #{@background_path}..."

    background_list = File.read(@background_path).split
    background_list.map! { |value| create_background(value) }
  end

  private

  def create_background(value)
    hex_color?(value) ? Background.new(value.to_i(16)) : Background.new(@asset_path + value)
  end

  def hex_color?(value)
    value.match(/^0x.._......$/) != nil
  end
end
