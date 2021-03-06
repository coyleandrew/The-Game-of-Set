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
        @last = 0

        # sleep time in seconds
        # random for a slight bit a variability
        if @difficulty == Difficulty::EASY
            @sleepTime = (35.0..45.0)
        elsif @difficulty == Difficulty::MEDIUM
            @sleepTime = (15.0..27.0)
        elsif @difficulty == Difficulty::HARD
            @sleepTime = (7.0..11.0)
        else
            @sleepTime = (1.0..3.5)
        end
    end
        
    # Sleeps for a set amount of time (depending on difficulty) then,
    # finds and returns a set
    def executeTurn time
        ## return if sleeping
        lapsed = time - @last
        if lapsed < rand(@sleepTime)
            # not time to claim yet
            return
        end
        @last = time

        # Cheating, just take a known set
        return @game.sets.sample
    end
end