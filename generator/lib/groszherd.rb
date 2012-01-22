module GroszHerd

  require 'RMagick'

  ROOTDIR = File.expand_path(File.dirname(__FILE__) + "/..")

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

        imagelist = ImageList.new(ROOTDIR + "/resources/plain_button.png")
        draw = Draw.new {
          self.pointsize = 324
          self.font = ROOTDIR + "/resources/fonts/COLOGNE.TTF"
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

    def innersquare_width
      (image.columns / Math.sqrt(2)).to_i
    end

    def delta_diameter_innersquare
      image.columns - innersquare_width
    end

  end

  class Sheet

    attr_reader :button

    include Magick

    def initialize year = Time.now.year
      @button = Button.new(year)
      @canvas = Image.new(4517, 6050){
        self.format = "PNG"
        self.background_color = "#FFFF"
      }
    end

    def image
      columns.times do |col|
        rows.times do |row|
          x = col * (@button.innersquare_width)
          y = row * ((@button.image.rows) + (@button.innersquare_width + @button.delta_diameter_innersquare / 2))
          y = (y + @button.innersquare_width + @button.delta_diameter_innersquare / 2) if col % 2 == 1
          @canvas.composite! @button.image.clone, x, y, Magick::AddCompositeOp
        end 
      end
      @canvas
    end

    def columns
      (@canvas.columns - @button.delta_diameter_innersquare) / @button.innersquare_width
    end

    def rows
      (@canvas.rows - @button.delta_diameter_innersquare) / @button.innersquare_width
    end

  end

end
