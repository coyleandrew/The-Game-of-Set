class Game
    def initialize
        reset
    end

    def reset
        @deck = Array.new(81)
        @deck = []
    end

    def newGame
        # Generate the deck, one of each
        @deck = Array.new(81)
        for i in 0...81
            # This is basically a binary table that runs from 0,0,0,0 to 2,2,2,2
            # Number has a +1 because it's base 1
            deck[i] = Card.new (i/(3*3*3)) % 3, (i/(3*3)) % 3, (i/3) % 3 + 1, i % 3
        end
        
        # this is neat, shuffle is a thing you can just do
        @deck.shuffle!

        # Move the first 12 cards from the deck to the board
        @board = @deck[0...16]
        @deck = @deck.drop 16
    end

    attr_accessor :score
    attr_accessor :deck
    attr_accessor :board

end