
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rothko/version"

Gem::Specification.new do |spec|
  spec.name          = "rothko"
  spec.version       = Rothko::VERSION
  spec.authors       = ["David Brennan"]
  spec.email         = ["ddbren@gmail.com"]

  spec.summary       = %q{Convert PNG graphics into pixel art in the terminal}
  spec.description   = %q{Provides the 'Drawing' class which is initialized with a filepath and a width. The image will be processed and put to the terminal as a collection of ANSI BG colored squares.}
  spec.homepage      = "https://github.com/ddbrennan/rothko"
  spec.license       = "MIT"
  spec.files         = Dir['lib/**/*.rb']
  spec.add_dependency "chunky_png", "~> 1.3.8"
  spec.add_dependency "colorize", "~> 0.8.1"
end
