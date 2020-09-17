require "Menu"

class Credits < Menu
    def initialize window
        super(window)

        @win = window
    end

    def get_header
        return Graphics::UI_THANKS
    end

    def get_items
        return [
            "Andrew Coyle",
            "Browy Li",
            "Josh Slaven",
            "Liangwei Xue",
            "Michael Dettmer",
            "Ok"
        ]
    end

    def show 
        # select the OK button, it's last
        @selected = get_items.length - 1
        prompt
    end
end