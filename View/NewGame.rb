require "Menu"

class NewGame < Menu
    def initialize window
        super(window)

        @win = window
        @players = 0
        @playerName = "Player 1"
        @difficulity = 0
    end

    def prompt! (game)
        loop do
            input = draw_menu generate_menu

            if input.include? "Difficulity"
                
            end

            return input
        end
    end

    def generate_menu
        return [
            "Name: #{@playerName}",
            "Difficulity: #{@difficulity.to_s}",
            "AI Players: #{@players.to_s}",
            "Play",
            "Back"
        ]
    end


end