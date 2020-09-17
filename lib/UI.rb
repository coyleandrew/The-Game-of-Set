require "ncurses"
require "Graphics"
require "Menu"
require "Board"
require "Score"
require "NewGame"
require "Credits"

class UI
  def initialize ()

    Ncurses.initscr
    Ncurses.cbreak

    # Configure colors
    Ncurses.start_color
    Ncurses.init_pair(1, 7, 0)
    Ncurses.init_pair(10, 1, 0)
    Ncurses.init_pair(11, 2, 0)
    Ncurses.init_pair(12, 5, 0)

    ## Selected
    Ncurses.init_pair(2, 0, 7)
    Ncurses.init_pair(20, 1, 7)
    Ncurses.init_pair(21, 2, 7)
    Ncurses.init_pair(22, 5, 7)

    ## Highlight
    Ncurses.init_pair(5, 6, 3)
    # Highlight AI 0
    Ncurses.init_pair(30, 1, 3)
    Ncurses.init_pair(31, 2, 3)
    Ncurses.init_pair(32, 5, 3)
    # Highlight AI 1
    Ncurses.init_pair(40, 1, 4)
    Ncurses.init_pair(41, 2, 4)
    Ncurses.init_pair(42, 5, 4)
    # Highlight AI 2
    Ncurses.init_pair(50, 1, 6)
    Ncurses.init_pair(51, 2, 6)
    Ncurses.init_pair(52, 5, 6)

    ## Hand
    Ncurses.init_pair(3, 7, 0)
    Ncurses.init_pair(4, 0, 0)

    # Removing normal input
    Ncurses.noecho
    Ncurses.stdscr.intrflush(true)
    Ncurses.curs_set 0
    Ncurses.stdscr.nodelay(true)
    
    # stops STDIN from blocking
    Ncurses.halfdelay 1


    @win = Ncurses.stdscr
    @menu = Menu.new(@win)

  end

  def intro
    @menu.intro
  end

  def menu
    return @menu.prompt
  end

  def newGame! (game)
    newGameMenu = NewGame.new @win
    return newGameMenu.prompt! game
    # init the new game view
  end
  
  def play (game)
    # init the game view    
    board = Board.new @win, game, game.player
    board.play
  end

  def score (game)
    score = Score.new @win
    score.show game
  end

  def credits
    credits = Credits.new @win
    credits.show
  end
end