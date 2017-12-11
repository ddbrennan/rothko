require "rothko/version"
require "colorize"
require "chunky_png"

module Rothko

  class Drawing

    attr_accessor :img, :width
    attr_reader :palette

    include ChunkyPNG::Color

    # Pallette of default ANSI colors. Closest match is found from this hash,
    # so these may be altered to produce a more faithful image or change colors.
    @@palette = {
      "g" => [0,230,22],
      "G" => [0,176,14],
      "w" => [230,229,230],
      "W" => [191,191,191],
      "r" => [252,0,0],
      "R" => [169,0,0],
      "k" => [102,102,102],
      "K" => [0,0,0],
      "m" => [255,0,228],
      "M" => [201,0,178],
      "c" => [0,236,234],
      "C" => [0,170,182],
      "b" => [70,0,255],
      "B" => [46,0,181],
      "y" => [223,237,0],
      "Y" => [149,158,0]
    }

    # Takes in the path to the PNG file and
    # the width (in 'pixels' - equivalent to two spaces)
    def initialize(path, width)
      input = ChunkyPNG::Image.from_file(path)
      @width = width
      @img = input.resample_nearest_neighbor(self.width, get_height(input))
      make_drawing
    end

    # Calls create_color_string to get an array of colors & split it into rows
    # Then iterates over that array, calling draw_line on each row
    def make_drawing
      ln_arr = create_color_string.scan(/.{#{self.width}}/)
      ln_arr.each {|ln| draw_line(ln.split(""))}
    end

    # Finds height of the image relative to provided width
    def get_height(img)
      new_height = img.height / (img.width.to_f / self.width.to_f)
    end

    # Iterates over each pixel of resized image to find closest color
    def create_color_string
      (0...img.height).map do |y|
        (0...img.width).map do |x|
          pix = self.img[x,y]
          pix_vals = [r(pix), g(pix), b(pix)]
          find_closest_term_color(pix_vals)
        end
      end.join
    end

    # Iterates over the palette to find the most similar color
    def find_closest_term_color(pixel_values)
      color = ""
      lil_dist = 195075
      @@palette.each do |col_name, col_values|
        dist = find_distance(col_values, pixel_values)
        if dist < lil_dist
          lil_dist = dist
          color = col_name
        end
      end
      color
    end

    # Helprt method
    def find_distance(color1, color2)
      delta_r = color1[0] - color2[0];
      delta_g = color1[1] - color2[1];
      delta_b = color1[2] - color2[2];
      delta_r * delta_r + delta_g * delta_g + delta_b * delta_b
    end

    # Takes in a string of colors and puts them out as background colored spaces
    # For example, "rGK" creates a light_red square, a green square, and a black square
    def draw_line(pixels)
      pix_line = ""
      pixels.each do |pixel|
        pix_line = pix_line + "  ".colorize(:background => find_color(pixel))
      end
      puts pix_line
    end

    # Matches letters to colors
    def find_color(letter)
      case letter
      when "R"
        :red
      when "r"
        :light_red
      when "B"
        :blue
      when "b"
        :light_blue
      when "C"
        :cyan
      when "c"
        :light_cyan
      when "Y"
        :yellow
      when "y"
        :light_yellow
      when "G"
        :green
      when "g"
        :light_green
      when "K"
        :black
      when "k"
        :light_black
      when "W"
        :white
      when "w"
        :light_white
      when "M"
        :magenta
      when "m"
        :light_magenta
      else
        :white
      end
    end

  end

end
