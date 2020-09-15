class GameController
    def initialize (game, ui)
        @game = game
        @ui = ui
        @running = true

        # Play the intro animation
        # Swamp these comments to skip the menu and jump stright to the game
        @ui.intro
        ##newGame
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
        puts "Controller got control back from newGame"
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