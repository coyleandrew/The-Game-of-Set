$LOAD_PATH << File.join(File.dirname(__FILE__), "UI")

require "ncurses"
require "Graphics"
require "Menu"

class UI
  def initialize ()

    Ncurses.initscr
    Ncurses.cbreak

    # Configure colors
    Ncurses.start_color
    Ncurses.init_pair(10, 1, 0)
    Ncurses.init_pair(11, 2, 0)
    Ncurses.init_pair(12, 5, 0)

    ## Selected
    Ncurses.init_pair(1, 0, 7)

    # Removing normal input
    Ncurses.noecho
    Ncurses.stdscr.intrflush(false)
    Ncurses.curs_set 0
    Ncurses.stdscr.nodelay(true)

    @win = Ncurses.stdscr
    @menu = Menu.new(@win)
    @board = Display.new(@win)

  end

  def intro
    @menu.intro
  end

  def prompt
    return @menu.prompt
  end

  def newGame (game)
    @board.printCards game.board
    # cursor is out of 12
    @board.cursor = [0,0]
    #TODO: Move this into a Board View
    while((ch = @win.getch()) != Ncurses::KEY_F1) do
      pos = @board.cursor
      case(ch)
      when Input::DOWN
        if pos[0] + 1 <= 1
          pos[0] += 1
        else
          pos[0] = 0
        end

        @board.printCards game.board
      when Input::UP
        if pos[0] - 1 >= 0
          pos[0] -= 1
        else
          pos[0] = 1
        end

        @board.printCards game.board
      when Input::LEFT
        if pos[1] - 1 >= 0
          pos[1] -= 1
        else
          pos[1] = 8
        end

        @board.printCards game.board
      when Input::RIGHT
        if pos[1] + 1 <= 7
          pos[1] += 1
        else
          pos[1] = 0
        end

        @board.printCards game.board
      when Input::ENTER
          return
      end
    end
  end

  def claim(cards)
    #TODO: Popup showing the claim
  end
end

class Display
  FRAME = [
    "|``````````````````|",
    "|                  |",
    "|                  |",
    "|                  |",
    "|                  |",
    "|                  |",
    "|                  |",
    "|__________________|"
  ].freeze

  FILL = [' ', '-', '#'].freeze

  def initialize(win)
    @win = win
    @cursor = 1
  end

  attr_accessor :cursor

  def printCard(cards)
    c = cards[@cursor]
    return "{color:#{c.color - 10},number:#{c.number},shade:#{c.fill},shape:#{c.shape}}"
  end

  def printCards(cards)
    @win.clear
    @win.move(0, 0)

    cardH = 8
    cardW = 20
    n_cols = (Ncurses.getmaxx(@win) / (cardW + 1)).floor

    col = 0
    row = 0

    # 2 x 8
    cards.each.with_index(0) do |card, _c_index|
      # helpful offsets to align the card
      y_pos = row * (cardH + 1) + 1 # +1 for the space between rows
      x_pos = (col * cardW) + (col + 1 % n_cols)

      # draw full card frame at position
      FRAME.each.with_index(0) do |str, i|
        if row == @cursor[0] && col == @cursor[1]
          @win.attrset(Ncurses.COLOR_PAIR(1))
        else
          @win.attrset(Ncurses.COLOR_PAIR(0))
        end

        @win.move(y_pos + i, x_pos)
        @win.addstr str
      end

      # deal with symbol spacing and position depending on number of symbols
      case card.number
      when 1
        symbol_start = 7
        symbol_width = 6
      when 2
        symbol_start = 3
        symbol_width = 8
      else
        symbol_start = 1
        symbol_width = 6
      end

      # print the symbol(s)
      $i = 0
      while $i < card.number
        x = x_pos + ($i * symbol_width) + symbol_start
        Graphics::SHAPES[card.shape].each.with_index(0) do |str, index|
          @win.move(y_pos + index + 1, x)
          @win.attrset(Ncurses.COLOR_PAIR(card.color))
          @win.addstr str.gsub('#', FILL[card.fill])
          @win.attrset(Ncurses.COLOR_PAIR(0))
        end
        $i += 1
      end

      # card position advancement
      if col + 1 > 7
        col = 0
        row += 1
      else
        col += 1
      end

      Ncurses.refresh

      # set the cursor past the cards, usefull when finished
      @win.move(y_pos + cardH + 1, 0)
    end
  end
end

class Card
  def initialize(s, c, n, f)
    @shape = s
    # Convert to color pair int
    @color = 10 + c
    @number = n
    @fill = f
  end

  attr_reader :shape

  attr_reader :number

  attr_reader :color

  attr_reader :fill
end