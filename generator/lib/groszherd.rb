module GroszHerd

  require 'RMagick'

  class Button

    include Magick

    Colors = ['white', '#ef2f15']
    
    def initialize year = Time.now.year
      @image = ImageList.new('/Users/clehmann/Desktop/Grosz-Herd/generator/resources/plain_button.png')
      @year = year.to_s
      @draw = Draw.new {
        self.pointsize = 324
        self.font = '/Users/clehmann/Desktop/Grosz-Herd/generator/resources/fonts/COLOGNE.TTF'
        self.font_weight = BoldWeight
        self.gravity = CenterGravity
      }
      @rendered = false
    end

    def display
      render
      @image.display
    end

    def save
      render
      @image.write '/Users/clehmann/Desktop/b.png'
    end
    
    def render
      unless @rendered

        year_segments = [@year[0..1], @year[2..3]]
        metrics = []

        year_segments.each_index { |i|
          metrics.push @draw.get_type_metrics(@image, year_segments[i])
        }

        @draw.annotate(@image, 0,0, -(metrics[0].width.to_i / 2) ,0, @year[0..1]) {
          self.fill = Colors[0]
        }

        @draw.annotate(@image, 0,0, metrics[1].width.to_i / 2 ,0, @year[2..3]) {
          self.fill = Colors[1]
        }

        @rendered = true
      end
    end

  end

  class Sheet

  end

end
