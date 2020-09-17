require "Menu"

class Score < Menu
    def initialize window
        super(window)

        @win = window
        @game = nil
    end

    def get_header
        return Graphics::UI_GAME_OVER
    end

    def get_items
        return get_scores @game
    end

    def show game
        @game = game
        # select the OK button, +2 for the player and the win line, zero index
        @selected = game.AI.length + 2
        prompt
    end

    def get_scores game

        # -1 achieves a descending sort
        results = [@game.player, *game.AI].sort_by { |p| p.score * -1 }

        score = ["#{results.first.name} wins!", *results.map { |ai| "#{ai.name} : #{ai.score}" }, "Ok"]

        return score
    end
end