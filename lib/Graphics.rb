class Graphics
    SHAPE_DIAMON = [
        "  /\\",
        " /##\\",
        "/####\\",
        "\\####/",
        " \\##/",
        "  \\/"
        ].freeze

    SHAPE_OVAL = [
        "  /\\",
        " |##|",
        " |##|",
        " |##|",
        " |##|",
        "  \\/"
    ].freeze

    SHAPE_SQUIGGLE = [
        "\\``\\",
        " \\##\\",
        "  |##|",
        " /##/",
        " \\##\\",
        "  \\__\\"
    ].freeze

    SHAPES = [Graphics::SHAPE_DIAMON, Graphics::SHAPE_OVAL, Graphics::SHAPE_SQUIGGLE].freeze

    UI_TERAM_THREE = [
        "  ____  ____   __   _  _      ____  _  _  ____  ____  ____  ",
        " (_  _)(  __) / _\\ ( \\/ ) ___(_  _)/ )( \\(  _ \\(  __)(  __) ",
        "   )(   ) _) /    \\/ \\/ \\(___) )(  ) __ ( )   / ) _)  ) _)  ",
        "  (__) (____)\\_/\\_/\\_)(_/     (__) \\_)(_/(__\\_)(____)(____) "
    ].freeze

    UI_PRESENTS = [
        "      ____  ____  ____  ____  ____  __ _  ____  ____        ",
        "     (  _ \\(  _ \\(  __)/ ___)(  __)(  ( \\(_  _)/ ___)       ",
        "      ) __/ )   / ) _) \\___ \\ ) _) /    /  )(  \\___ \\       ",
        "     (__)  (__\\_)(____)(____/(____)\\_)__) (__) (____/       "
    ].freeze

    UI_LOGO = [
        "                         A GAME OF                          ",
        " .----------------.  .----------------.  .----------------. ",
        "| .--------------. || .--------------. || .--------------. |",
        "| |    _______   | || |  _________   | || |  _________   | |",
        "| |   /  ___  |  | || | |_   ___  |  | || | |  _   _  |  | |",
        "| |  |  (__ \\_|  | || |   | |_  \\_|  | || | |_/ | | \\_|  | |",
        "| |   '.___`-.   | || |   |  _|  _   | || |     | |      | |",
        "| |  |`\____)  |  | || |  _| |___/ |  | || |    _| |_     | |",
        "| |  |_______.'  | || | |_________|  | || |   |_____|    | |",
        "| |              | || |              | || |              | |",
        "| '--------------' || '--------------' || '--------------' |",
        " '----------------'  '----------------'  '----------------' "
    ].freeze

    UI_GAME_OVER = [
        "                         A GAME OF SET                      ",
        "        ___   __   _  _  ____     __   _  _  ____  ____     ",
        "       / __) / _\\ ( \\/ )(  __)   /  \\ / )( \\(  __)(  _ \\    ",
        "      ( (_ \\/    \\/ \\/ \\ ) _)   (  O )\\ \\/ / ) _)  )   /    ",
        "       \\___/\\_/\\_/\\_)(_/(____)   \\__/  \\__/ (____)(__\\_)    "
    ].freeze

    UI_CARD_FRAME = [
        "|```````````````````|",
        "|                   |",
        "|                   |",
        "|                   |",
        "|                   |",
        "|                   |",
        "|                   |",
        "|___________________|"
    ].freeze

    UI_CARD_FRAME_SELECTED = [
        "[===================]",
        "[                   ]",
        "[                   ]",
        "[                   ]",
        "[                   ]",
        "[                   ]",
        "[                   ]",
        "[===================]"
    ].freeze

    UI_CARD_EMPTY = [
        "                     ",
        "                     ",
        "                     ",
        "                     ",
        "                     ",
        "                     ",
        "                     ",
        "                     "
    ].freeze

    SHAPE_FILL = [' ', '-', '#'].freeze
    
end