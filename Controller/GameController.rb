require "Player"
require "AIPlayer"

class GameController
    def initialize (game, ui)
        @game = game
        @ui = ui
        @running = true
    end

    # Main game loop
    def run
        # Disable animated intro for the sake of dev sanity
        @ui.intro

        loop do
            command = @ui.menu
            case command
            when "Exit "
                quit
            when "Credits"
                showCredits
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
        #init a new game model
        @game.reset
        @game.newGame

        # prompt to configure the game
        command = @ui.newGame! @game
        if(command == "Play")
            play
        end
    end

    def play
        # create the player
        @game.player = Player.new @game.playerName
        # create the AIs
        @game.players.times { |i| @game.AI[i] = AIPlayer.new "AI #{i + 1}", @game.difficulty, @game }
        # play the game
        @ui.play @game
        # end it
        endGame
    end

    def endGame
        # show the score
        @ui.score @game
    end

    def showCredits
        @ui.credits
    end
end