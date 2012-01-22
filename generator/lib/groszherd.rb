module GroszHerd

  require 'RMagick'

  class Button

    include Magick

    Colors = ['white', '#ef2f15']
    
    def initialize year = Time.now.year
      @year = year.to_s
      raise ArgumentError, "Year must have 4 numbers." unless @year.length == 4
      @button_image = nil
    end

    def display
      image.display
    end

    def save filename
      image.write filename
    end
    
    def image
      if @button_image == nil

        imagelist = ImageList.new('/Users/clehmann/Desktop/Grosz-Herd/generator/resources/plain_button.png')
        draw = Draw.new {
          self.pointsize = 324
          self.font = '/Users/clehmann/Desktop/Grosz-Herd/generator/resources/fonts/COLOGNE.TTF'
          self.font_weight = BoldWeight
          self.gravity = CenterGravity
        }
        year_segments = [@year[0..1], @year[2..3]]
        metrics = []

        year_segments.each_index { |i|
          metrics.push draw.get_type_metrics(imagelist, year_segments[i])
        }

        draw.annotate(imagelist, 0,0, -(metrics[0].width.to_i / 2) ,0, @year[0..1]) {
          self.fill = Colors[0]
        }

        draw.annotate(imagelist, 0,0, metrics[1].width.to_i / 2 ,0, @year[2..3]) {
          self.fill = Colors[1]
        }

        @button_image = imagelist.flatten_images

      end
      @button_image
    end

  end

  class Sheet

    attr_reader :button

    def initialize year = Time.now.year
      @button = Button.new(year).image
    end

  end

end
