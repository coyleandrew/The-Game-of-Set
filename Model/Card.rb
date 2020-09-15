#file: Card.rb
class Card
    def initialize(shape, color, number, shading)
        @shape = shape
        @color = color + 10
        @number = number
        @fill = shading
    end

    attr_reader :shape
  
    attr_reader :number
  
    attr_reader :color
  
    attr_reader :fill
end