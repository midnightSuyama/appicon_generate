require 'fileutils'
require 'RMagick'

module AppiconGenerate
  DEST_PATH = 'icons'
  Icon = Struct.new(:path, :px)

  class << self
    def run(file, options)
      icons = []
      icons += icons_ios if options[:ios]
      icons += icons_android if options[:android]

      img = Magick::Image.read(file).first
      icons.each do |icon|
        path = "#{DEST_PATH}/#{icon.path}"
        FileUtils.mkdir_p File.dirname(path)
        img.resize(icon.px, icon.px).write(path)
      end
      img.destroy!
    end

    private

    def icons_ios
      icons = []
      [
        ['Icon.png',             57],
        ['Icon@2x.png',          114],
        ['Icon-60.png',          60],
        ['Icon-60@2x.png',       120],
        ['Icon-60@3x.png',       180],
        ['Icon-72.png',          72],
        ['Icon-72@2x.png',       144],
        ['Icon-76.png',          76],
        ['Icon-76@2x.png',       152],
        ['Icon-83.5@2x.png',     167],
        ['Icon-Small.png',       29],
        ['Icon-Small@2x.png',    58],
        ['Icon-Small@3x.png',    87],
        ['Icon-Small-50.png',    50],
        ['Icon-Small-50@2x.png', 100],
        ['Icon-40.png',          40],
        ['Icon-40@2x.png',       80],
        ['Icon-40@3x.png',       120],
        ['iTunesArtwork.png',    512],
        ['iTunesArtwork@2x.png', 1024],
      ].each do |path, px|
        icons << Icon.new("ios/#{path}", px)
      end
      icons
    end

    def icons_android
      icons = []
      [
        ['drawable-ldpi/ic_launcher.png',    36],
        ['drawable-mdpi/ic_launcher.png',    48],
        ['drawable-hdpi/ic_launcher.png',    72],
        ['drawable-xhdpi/ic_launcher.png',   96],
        ['drawable-xxhdpi/ic_launcher.png',  144],
        ['drawable-xxxhdpi/ic_launcher.png', 192],
        ['store.png',                        512],
      ].each do |path, px|
        icons << Icon.new("android/#{path}", px)
      end
      icons
    end

  end
end
