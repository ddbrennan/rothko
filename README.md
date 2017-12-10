# Rothko

Provides the 'Rothko::Drawing' class which is initialized with a filepath and a width. The image will be processed and put to the terminal as a collection of ANSI BG colored squares.

Named for Mark Rothko, painter of squares.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rothko'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rothko

## Usage

Example code:

Rothko::Drawing.new('windows.png', 100)

The result of this is a 100 'pixel' (pixel = two empty spaces with a colored background) wide image of the Windows "Bliss" background. The pallette leaves a lot of photos looking muddied, so I recommend creating original artwork that conforms to the limitations of the medium. 

https://www.piskelapp.com/ is great for this - just use the ANSI color palette (included in this directory) and the result will look just like your work.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ddbrennan/rothko.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
