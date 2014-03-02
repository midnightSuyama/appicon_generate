# coding: utf-8

require 'rubygems'
require 'spec_helper'
require 'fileutils'
require 'image_size'

describe AppiconGenerate do
  before :all do
    Dir.mkdir('tmp') unless Dir.exists?('tmp')
    Dir.chdir('tmp')
  end

  # iOS
  context 'when generate icon of iOS' do
    before(:all) do
      AppiconGenerate.run("#{File.dirname(__FILE__)}/fixtures/source.png", {:ios => true})
    end

    after(:all) do
      FileUtils.rm_r(AppiconGenerate::DEST_PATH)
    end

    [
      ['Icon.png',             57],
      ['Icon@2x.png',          114],
      ['Icon-60.png',          60],
      ['Icon-60@2x.png',       120],
      ['Icon-72.png',          72],
      ['Icon-72@2x.png',       144],
      ['Icon-76.png',          76],
      ['Icon-76@2x.png',       152],
      ['Icon-Small.png',       29],
      ['Icon-Small@2x.png',    58],
      ['Icon-Small-50.png',    50],
      ['Icon-Small-50@2x.png', 100],
      ['Icon-40.png',          40],
      ['Icon-40@2x.png',       80],
      ['iTunesArtwork.png',    512],
      ['iTunesArtwork@2x.png', 1024],
    ].each do |path, px|
      path = "#{AppiconGenerate::DEST_PATH}/ios/#{path}"

      context "'#{path}'" do
        before(:all) do
          @image_size = ImageSize.path(path)
        end

        it 'should exist' do
          File.exists?(path).should be_true
        end

        it 'format should be png' do
          @image_size.format.should eq :png
        end

        it "width should be #{px}px" do
          @image_size.width.should eq px
        end

        it "height should be #{px}px" do
          @image_size.height.should eq px
        end
      end
    end
  end

  # Android
  context 'when generate icon of Android' do
    before(:all) do
      AppiconGenerate.run("#{File.dirname(__FILE__)}/fixtures/source.png", {:android => true})
    end

    after(:all) do
      FileUtils.rm_r(AppiconGenerate::DEST_PATH)
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
        before(:all) do
          @image_size = ImageSize.path(path)
        end

        it 'should exist' do
          File.exists?(path).should be_true
        end

        it 'format should be png' do
          @image_size.format.should eq :png
        end

        it "width should be #{px}px" do
          @image_size.width.should eq px
        end

        it "height should be #{px}px" do
          @image_size.height.should eq px
        end
      end
    end
  end
end
