require "Graphics"
require "Input"

class Menu
    def initialize(window)
        @win = window
        @selected = 0

        @maxX = Ncurses.getmaxx(@win)
        @maxY = Ncurses.getmaxy(@win)

        @team = Graphics::UI_TERAM_THREE
        @presents = Graphics::UI_PRESENTS
    end

    def get_header
        return Graphics::UI_LOGO
    end

    def get_items
        return Menu::MENU_ITEMS
    end

    def resize
        @maxX = Ncurses.getmaxx(@win)
        @maxY = Ncurses.getmaxy(@win)

        # Center the screen
        @width = get_header[0].length
        @height = get_header.length + 3 + get_items.length * 2

        # Top left position to center the splash screen
        @left = (@maxX - @width) / 2
        @top = (@maxY - @height) / 2
    end

    def intro
        @win.clear
        @win.move(0, 0)

        x = @left
        y = @top

        logo = get_header

        printArray x, y, @team, Ncurses.COLOR_PAIR(0)
        @win.refresh
        sleep(0.25)
        y += @team.length + 1
        printArray x, y, @presents, Ncurses.COLOR_PAIR(0)
        @win.refresh
        sleep(0.5)
        y += @presents.length + 1
        printArray x, y, logo, Ncurses.COLOR_PAIR(0)
        @win.refresh
        sleep(1.5)

        # slide the logo up
        loop do
            # draw the logo one line up
            y -= 1
            printArray x, y, logo, Ncurses.COLOR_PAIR(0)
            @win.move(y + logo.length, 0)
            @win.clrtoeol

            @win.refresh
            sleep(0.1)

            break unless y > 2
        end
    end

    def prompt
        resize
        @win.clear
        draw_menu get_items, get_header
    end

    def draw_menu (items, header)

        # Initial Draw
        draw @selected, items, header

        while((ch = @win.getch()) != Ncurses::KEY_F1) do

            case(ch)
            when Input::DOWN
                if @selected + 1 < items.length
                    @selected += 1
                else
                    @selected = 0
                end
            when Input::UP
                if @selected -1 >= 0
                    @selected -= 1
                else
                    @selected = items.length - 1
                end
            when Input::ENTER
                return items[@selected]
            end
            
            # deal with window size changing
            if @maxX != Ncurses.getmaxx(@win) || @maxY != Ncurses.getmaxy(@win)
                resize
            end

            draw @selected, items, header
        end
        
    end

    MENU_ITEMS = [
        "New Game",
        "Credits",
        "Exit "
    ].freeze

    # Position of a single menu item
    def menu_position (index, text)
        y = get_header.length + 2 + index * 2
        x = @left + ((@width - text.length) / 2).floor
        return [x, y]
    end

    # draw the view
    def draw (selected, items, header)

        printArray @left, @top, header, Ncurses.COLOR_PAIR(0)
        
        y = @top + header.length + 1
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

    attr_accessor :selected
end