require "Menu"
require 'scanf'

class NewGame < Menu
    def initialize window
        super(window)

        @win = window
        @game = nil
    end

    def get_header
        return Graphics::UI_LOGO
    end

    def get_items
        return generate_menu @game
    end

    def prompt! (game)
        @game = game
        loop do
            input = prompt

            if input.include? "Difficulity:"
                game.difficulty = (game.difficulty + 1) % 4
            elsif input.include? "Name:"

                # remove the current player name and redraw the menu with a blank
                game.playerName = "__________"
                # -1 selects nothing
                draw -1, get_items, get_header
                
                # switch to text entry mode
                Ncurses.echo
                Ncurses.stdscr.nodelay(false)
                Ncurses.curs_set 1

                # print prompt
                menuPos = menu_position 0, (generate_menu game)[0]
                # Slight shift to the left for the name prompt. Looks better.
                @win.mvaddstr(menuPos[1], menuPos[0], "Name: ")
                @win.refresh

                # get name input
                name = []
                @win.scanw("%s%s%s", name)
                game.playerName = name.join " "

                # disable text entry mode
                Ncurses.noecho
                Ncurses.stdscr.nodelay(true)
                Ncurses.curs_set 0

            elsif input.include? "AI Players:"
                game.players = (game.players + 1) % 4
            else
                return input
            end
        end
    end

    def generate_menu game
        return [
            "Name: #{game.playerName}",
            "Difficulity: #{difficulity_to_s game.difficulty}",
            "AI Players: #{game.players.to_s}",
            "Play",
            "Back"
        ]
    end

    def difficulity_to_s d
        case d
        when Difficulty::EASY
            return "Easy"
        when Difficulty::MEDIUM
            return "Medium"
        when Difficulty::HARD
            return "Hard"
        else
            return "Impossible"
        end
    end

end