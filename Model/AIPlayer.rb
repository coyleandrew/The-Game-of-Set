=being
This class creates AI players for the game of set.
Each object should be constructed using one string paramter @difficulty
which can either be "Easy", "Medium", or "Hard".
=end
class AIPlayer
    # @difficulty: difficulty level of the AI set by the player
    # @sleepTime: the time the AI should sleep during it's turn
    attr_accessor :difficulty 
    @sleepTime

    def initialize(attributes = {})
        @difficulty = attributes[:difficulty]

        if @difficulty == "Easy"
            @sleepTime = 20
        elsif @difficulty == "Medium"
            @sleepTime = 10
        else
            @sleepTime = 5

    # Sleeps for a set amount of time (depending on difficulty) then,
    # finds and returns a set
    def executeTurn
        sleep(@sleepTime)
        # TODO: Write FindSet() method
