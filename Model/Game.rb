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
        @time = 0
        @player = nil
        @sets = []
    end

    def newGame
        # Generate the deck, one of each
        @deck = []

        # This is basically a binary table that runs from 0,0,0,0 to 2,2,2,2
        # Number has a +1 because it's base 1
        (0...81).each { |i| deck[i] = Card.new (i/(3*3*3)) % 3, (i/(3*3)) % 3, (i/3) % 3 + 1, i % 3 }
        
        # this is neat, shuffle is a thing you can just do
        @deck.shuffle!

        # Move the first 12 cards from the deck to the board
        @cards = @deck[0...12]
        @deck = @deck.drop 12
        @sets = IsASet.sets @cards
    end

    # claim a collection of cards as a set.
    # Nil's Cards cards if removed from play as a result of the claim
    # Returns true if the set is A Set
    def claim! (player, set)
        if IsASet.is_set set

            # nil claimed cards
            set.each do |card|
                @cards[@cards.index card] = nil
            end

            # award player the set
            player.add(set)

            # return result
            return success
        end

        return false
    end

    # Can a set be claimed?
    def claim? (set)
        return IsASet.is_set set
    end

    def updateAI ai
        return ai.executeTurn @time
    end

    # Fill in missing cards
    def deal
        ## assigns nil refenreces by popping a card from the deck
        @cards.map! { |x| x || @deck.pop }

        # recompute sets
        @game.sets = IsASet.sets @cards
    end

    attr_accessor :difficulty
    attr_accessor :players
    attr_accessor :player
    attr_accessor :playerName
    attr_accessor :deck
    attr_accessor :cards
    attr_accessor :AI
    attr_accessor :time

end