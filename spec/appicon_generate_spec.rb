# coding: utf-8

require 'spec_helper'
require 'fileutils'
require 'image_size'

shared_context 'icon' do |path, px|
  before :all do
    @image_size = ImageSize.path(path)
  end

  it 'should exist' do
    expect(File.exists? path).to be true
  end

  it 'format should be png' do
    expect(@image_size.format).to eq :png
  end

  it "width should be #{px}px" do
    expect(@image_size.width).to eq px
  end

  it "height should be #{px}px" do
    expect(@image_size.height).to eq px
  end
end

describe AppiconGenerate do
  before :all do
    Dir.mkdir 'tmp' unless File.exists? 'tmp'
    Dir.chdir 'tmp'
  end

  after :all do
    Dir.chdir '..'
    FileUtils.rm_r 'tmp'
  end

  # iOS
  context 'when generate icon for iOS' do
    before :all do
      AppiconGenerate.run("#{File.dirname(__FILE__)}/fixtures/source.png", {:ios => true})
    end

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
      path = "#{AppiconGenerate::DEST_PATH}/ios/#{path}"

      context "'#{path}'" do
        include_context 'icon', [path, px]
      end
    end
  end

  # Android
  context 'when generate icon of Android' do
    before :all do
      AppiconGenerate.run("#{File.dirname(__FILE__)}/fixtures/source.png", {:android => true})
    end

    [
      ['drawable-ldpi/ic_launcher.png',    36],
      ['drawable-mdpi/ic_launcher.png',    48],
      ['drawable-hdpi/ic_launcher.png',    72],
      ['drawable-xhdpi/ic_launcher.png',   96],
      ['drawable-xxhdpi/ic_launcher.png',  144],
      ['drawable-xxxhdpi/ic_launcher.png', 192],
      ['store.png',                        512],
    ].each do |path, px|
      path = "#{AppiconGenerate::DEST_PATH}/android/#{path}"

      context "'#{path}'" do
        include_context 'icon', [path, px]
      end
    end
  end
end
