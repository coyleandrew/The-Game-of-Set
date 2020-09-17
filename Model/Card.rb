#file: Card.rb
class Card
    def initialize(shape, color, number, shading)
        @shape = shape
        @color = color + 10
        @number = number
        @fill = shading
    end

    def to_s()
        "Shape: %s, Color: %s, Number: %s, Fill: %s" % [@shape, @color, @number, @fill]
    end

    attr_reader :shape
  
    attr_reader :number
  
    attr_reader :color
  
    attr_reader :fill
end