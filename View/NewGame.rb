require "Menu"
require 'scanf'

class NewGame < Menu
    def initialize window
        super(window)

        @win = window
    end

    def prompt! (game)
        loop do
            input = draw_menu generate_menu game

            if input.include? "Difficulity:"
                game.difficulty = (game.difficulty + 1) % 3
            elsif input.include? "Name:"

                # remove the current player name and redraw the menu with a blank
                game.playerName = "__________"
                draw_options -1, (generate_menu game)
                
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
        when 0
            return "Easy"
        when 1
            return "Medium"
        else
            return "Hard"
        end
    end

end