# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'appicon_generate/version'

Gem::Specification.new do |spec|
  spec.name          = "appicon_generate"
  spec.version       = AppiconGenerate::VERSION
  spec.authors       = ["midnightSuyama"]
  spec.email         = ["midnightSuyama@gmail.com"]
  spec.summary       = "Generate icon of iOS, Android"
  spec.description   = "Generate icon of iOS, Android"
  spec.homepage      = "https://github.com/midnightSuyama/appicon_generate"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "image_size"

  spec.add_runtime_dependency "rmagick"
end
