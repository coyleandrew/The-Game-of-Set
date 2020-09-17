require "Card"
require "IsASet"

class Game
    def initialize
        reset

        # defauls
        @difficulty = 0
        @playerName = "Player 1"
        @players = 1

        @dealCount = 0
    end

    def reset
        @deck = Array.new(81)
        @cards = []
        @AI = []
        @time = 0
        @player = nil
        @sets = nil
    end

    def newGame
        # Generate the deck, one of each
        @deck = []

        # This is basically a binary table that runs from 0,0,0,0 to 2,2,2,2
        # Number has a +1 because it's base 1
        (0...81).each { |i| deck[i] = Card.new (i/(3*3*3)) % 3, (i/(3*3)) % 3, (i/3) % 3 + 1, i % 3 }
        
        # this is neat, shuffle is a thing you can just do
        @deck.shuffle!

        # Establish the play surface
        @cards = Array.new 12

        # deal the first cards
        deal
        
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
            return true
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
        # pack cards past the default 12 into the begining
        if @cards.length > 12
            # cards still in play past the standard 12 positions
            extra = @cards.last(@cards.length - 12).compact
            # move what can be moved into the standard 12 positions
            @cards = @cards.take(12).map! { |c| c || extra.pop }
            # hopefully extra is empty now, but maybe not
            @cards += extra
        end

        # sets is still valid as we haven't modified the combinaion of cards in play
        # do we need to expand the cards in play?
        if(@sets && @sets.none?)
            @cards += Array.new(3)
        end
        
        ## fill any gaps from the deck
        @cards.map! { |x| x || @deck.pop }

        # recompute sets
        #@sets = []
        @sets = IsASet.sets @cards.compact
    end

    attr_accessor :difficulty
    attr_accessor :players
    attr_accessor :player
    attr_accessor :playerName
    attr_accessor :deck
    attr_accessor :cards
    attr_accessor :sets
    attr_accessor :AI
    attr_accessor :time

end