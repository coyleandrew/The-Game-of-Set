require "Card"

class Game
    def initialize
        reset
    end

    def reset
        @deck = Array.new(81)
        @cards = []
        @AI = []
        @difficulty = 0
        @playerName = "Player 1"
        @players = 1
    end

    def newGame
        # Generate the deck, one of each
        @deck = Array.new(81)

        # This is basically a binary table that runs from 0,0,0,0 to 2,2,2,2
        # Number has a +1 because it's base 1
        (0...81).each { |i| deck[i] = Card.new (i/(3*3*3)) % 3, (i/(3*3)) % 3, (i/3) % 3 + 1, i % 3 }
        
        # this is neat, shuffle is a thing you can just do
        @deck.shuffle!

        # Move the first 12 cards from the deck to the board
        @cards = @deck[0...12]
        @deck = @deck.drop 12
    end

    def claim (player, set)
        #TODO: Do the claim work
    end

    attr_accessor :difficulty
    attr_accessor :players
    attr_accessor :playerName
    attr_accessor :deck
    attr_accessor :cards
    attr_accessor :AI

end