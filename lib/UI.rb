require "ncurses"
require "Graphics"
require "Menu"
require "Board"

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

    ## Hand
    Ncurses.init_pair(3, 7, 0)
    Ncurses.init_pair(4, 0, 0)

    # Removing normal input
    Ncurses.noecho
    Ncurses.stdscr.intrflush(false)
    Ncurses.curs_set 0
    Ncurses.stdscr.nodelay(false)

    @win = Ncurses.stdscr
    @menu = Menu.new(@win)

  end

  def intro
    @menu.intro
  end

  def prompt
    return @menu.prompt
  end

  def newGame (game, player)
    # init the game view    
    board = Board.new(@win, game, player)
    board.play
  end

  def claim(cards)
    #TODO: Popup showing the claim
  end
end

class Display

  def initialize(win)
    @win = win
    @cursor = 1
  end

  attr_accessor :cursor

  def printCard(cards)
    c = cards[@cursor]
    return "{color:#{c.color - 10},number:#{c.number},shade:#{c.fill},shape:#{c.shape}}"
  end

  
end