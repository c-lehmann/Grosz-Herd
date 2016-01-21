require "pry"
module GroszHerd

  require 'RMagick'

  ROOTDIR = File.expand_path(File.dirname(__FILE__) + "/..")

  class Button

    PADDING = 0
    Colors = ['white', '#ef2f15']
    
    include Magick

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
          self.pointsize = 300
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

    PADDING = 50

    attr_reader :button

    include Magick

    def initialize year = Time.now.year
      @button = Button.new(year)
      @canvas = Image.new(4517, 6050)
      #@canvas = Image.new(6050, 4517)
      
      @canvas.format = "PNG"
      @canvas.background_color = "#FFFF"
      @canvas.units = @button.image.units
      @canvas.x_resolution = @button.image.x_resolution
      @canvas.y_resolution = @button.image.y_resolution
    end

    def image
      
      r = PADDING + @button.image.columns / 2
      current_row = 0

      top = PADDING

      while top < @canvas.rows do
        
        if current_row % 2 == 0
          left = PADDING
        else 
          left = PADDING - r
        end

        while left < @canvas.columns do
          @canvas.composite!(@button.image.clone, left, top, Magick::AddCompositeOp) if is_fitting top, left, r 
          left = left + 2*r
        end
        top = top + (Math.sqrt(3) * r).to_i
        current_row = current_row + 1
      end
      @canvas
    end
    
    private

    def is_fitting top, left, r
      left >= 0 && @canvas.columns > left + 2 * r && @canvas.rows > top + 2 * r
    end

  end

end
