require "Player"
require "AIPlayer"

class GameController
    def initialize (game, ui)
        @game = game
        @ui = ui
        @running = true

        # Play the intro animation
        # Swap these comments to skip the menu and jump stright to the game
        #@ui.intro
        newGame
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
        #init a new game model
        @game.newGame

        # prompt to configure the game
        command = @ui.newGame! @game
        if(command == "Play")
            play
        end
    end

    def play
        # create the player
        player = Player.new  @game.playerName, [], 0
        # create the AIs
        @game.players.times { |i| @game.AI[i] = AIPlayer.new @game.difficulty, @game }
        # start the game
        @ui.play @game, player
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