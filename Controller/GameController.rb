class GameController
    def initialize (game, ui)
        @game = game
        @ui = ui
        @running = true

        # Play the intro animation
        @ui.intro
    end

    # Main game loop
    def run
        loop do
            command = @ui.prompt
            case command
            when "Exit "
                quit
            when "New Game"
                newGame
            end

            break unless @running
        end
    end

    def quit
        @running = false
    end

    def newGame
        @game.newGame
        @ui.newGame @game
    end

    def endGame
        #TODO: Score board
        #TODO: Short circut the game to trigger the menu prompt
    end

    def claimSet(player, cards)
        # TODO: IsASet
        # TODO: UI feedback
        # TODO: 
    end
end