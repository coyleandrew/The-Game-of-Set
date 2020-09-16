require "Menu"

class Score < Menu
    def initialize window
        super(window)

        @win = window
    end

    def show game
        # select the OK button, +1 for the player, zero index
        @selected = game.AI.length + 1
        draw_menu get_scores game
    end

    def get_scores game
        score = []
        score[0] = "#{game.player.name} : #{game.player.score}"
        score += game.AI.map { |ai| "#{ai.name} : #{ai.score}" }
        score.push "OK"
    end
end