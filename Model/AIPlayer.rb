=begin
This class creates AI players for the game of set.
Each object should be constructed using one string paramter @difficulty
which can either be "Easy", "Medium", or "Hard".
=end
require "Difficulty"

#TODO: Inhert from Player so score will work
class AIPlayer < Player
    # @difficulty: difficulty level of the AI set by the player
    # @sleepTime: the time the AI should sleep during it's turn
    attr_accessor :difficulty 
    @sleepTime

    def initialize(name, difficulty, game)
        super(name)

        @difficulty, @game = difficulty, game

        if @difficulty == Difficulty::EASY
            @sleepTime = 20
        elsif @difficulty == Difficulty::MEDIUM
            @sleepTime = 10
        else
            @sleepTime = 5
        end
    end
        
    # Sleeps for a set amount of time (depending on difficulty) then,
    # finds and returns a set
    def executeTurn time
        #sleep(@sleepTime)
        #TODO:
        #sleep locks the thread, not going to work
        #new plan, time is the total seconds since the game started
        #you'll need to start tracking when your last turn was and do turn work if time - last > @sleepTime

        # TODO: Write FindSet() method
        set = @game.cards.sample 3

        if set.length == 3
            @game.claim!(self, set)
        end
    end
end