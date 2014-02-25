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
        FileUtils.mkdir_p(File.dirname(path))
        img.resize(icon.px, icon.px).write(path)
      end
      img.destroy!
    end

    private

    def icons_ios
      path = 'ios'
      [
       Icon.new("#{path}/Icon.png",             57),
       Icon.new("#{path}/Icon@2x.png",          114),
       Icon.new("#{path}/Icon-60.png",          60),
       Icon.new("#{path}/Icon-60@2x.png",       120),
       Icon.new("#{path}/Icon-72.png",          72),
       Icon.new("#{path}/Icon-72@2x.png",       144),
       Icon.new("#{path}/Icon-76.png",          76),
       Icon.new("#{path}/Icon-76@2x.png",       152),
       Icon.new("#{path}/Icon-Small.png",       29),
       Icon.new("#{path}/Icon-Small@2x.png",    58),
       Icon.new("#{path}/Icon-Small-50.png",    50),
       Icon.new("#{path}/Icon-Small-50@2x.png", 100),
       Icon.new("#{path}/Icon-40.png",          40),
       Icon.new("#{path}/Icon-40@2x.png",       80),
       Icon.new("#{path}/iTunesArtwork.png",    512),
       Icon.new("#{path}/iTunesArtwork@2x.png", 1024),
      ]
    end

    def icons_android
      path = 'android'
      [
       Icon.new("#{path}/drawable-ldpi/ic_launcher.png",    36),
       Icon.new("#{path}/drawable-mdpi/ic_launcher.png",    48),
       Icon.new("#{path}/drawable-hdpi/ic_launcher.png",    72),
       Icon.new("#{path}/drawable-xhdpi/ic_launcher.png",   96),
       Icon.new("#{path}/drawable-xxhdpi/ic_launcher.png",  144),
       Icon.new("#{path}/drawable-xxxhdpi/ic_launcher.png", 192),
       Icon.new("#{path}/store.png",                        512),
      ]
    end
  end
end
