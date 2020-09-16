require "Graphics"
require "Input"

class Menu
    def initialize(window)
        @win = window
        @selected = 0

        @team = Graphics::UI_TERAM_THREE
        @presents = Graphics::UI_PRESENTS
        @logo = Graphics::UI_LOGO

        # Center the screen
        maxX = Ncurses.getmaxx(@win)
        maxY = Ncurses.getmaxy(@win)
        @width = @team[0].length
        @height = @team.length + 1 + @presents.length + 1 + @logo.length

        # Top left position to center the splash screen
        @left = ((maxX - @width) / 2).floor
        @top = ((maxY - @height) / 2).floor
    end

    def intro
        @win.clear
        @win.move(0, 0)

        x = @left
        y = @top

        printArray x, y, @team, Ncurses.COLOR_PAIR(0)
        @win.refresh
        sleep(0.25)
        y += @team.length + 1
        printArray x, y, @presents, Ncurses.COLOR_PAIR(0)
        @win.refresh
        sleep(0.5)
        y += @presents.length + 1
        printArray x, y, @logo, Ncurses.COLOR_PAIR(0)
        @win.refresh
        sleep(1.5)

        # slide the logo up
        loop do
            # draw the logo one line up
            y -= 1
            printArray x, y, @logo, Ncurses.COLOR_PAIR(0)
            @win.move(y + @logo.length, 0)
            @win.clrtoeol

            @win.refresh
            sleep(0.1)

            break unless y > 2
        end
    end

    def prompt
        draw_menu Menu::MENU_ITEMS
    end

    def draw_menu items
        @win.clear

        draw_options @selected, items

        while((ch = @win.getch()) != Ncurses::KEY_F1) do

            case(ch)
            when Input::DOWN
                if @selected + 1 < items.length
                    draw_options @selected += 1, items
                else
                    draw_options @selected = 0, items
                end
            when Input::UP
                if @selected -1 >= 0
                    draw_options @selected -= 1, items
                else
                    draw_options @selected = items.length - 1, items
                end
            when Input::ENTER
                return items[@selected]
            end
        end
        
    end

    MENU_ITEMS = [
        "New Game",
        "Credits",
        "Exit "
    ].freeze

    def menu_position (index, text)
        y = @logo.length + 3 + index * 2
        x = @left + ((@width - text.length) / 2).floor
        return [x, y]
    end

    def draw_options (selected, items)
        @win.clear

        printArray @left, @top, @logo, Ncurses.COLOR_PAIR(0)
        
        y = @logo.length + 3
        items.each.with_index(0) do |item, i|
            x = @left + ((@width - item.length) / 2).floor

            if i == selected
                @win.attrset(Ncurses.COLOR_PAIR(2))
            else
                @win.attrset(Ncurses.COLOR_PAIR(1))
            end

            @win.move(y, x)
            @win.addstr(item)
            @win.clrtoeol

            y += 2
        end

        # put the cursor ont he selected thing

        @refresh
    end

    def doCommandOrExit? selected
        case Menu::MENU_ITEMS[selected]
        when "Exit"
            return true
        when "New Game"
            
        end
        return false
    end

    def printArray(x, y, array, color)
        array.each.with_index(0) do |str, i|
            @win.attrset(color)
            @win.move(y + i, x)
            @win.addstr str
        end
    end
end