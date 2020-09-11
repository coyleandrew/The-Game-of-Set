require "ncurses"

class UI
    
    def initialize

      Ncurses.initscr
      Ncurses.cbreak

      # Configure colors
      Ncurses.start_color
      Ncurses.init_pair(10, 1, 0)
      Ncurses.init_pair(11, 2, 0)
      Ncurses.init_pair(12, 5, 0)

      Ncurses.init_pair(1, 0, 7)


      # Removing normal input
      Ncurses.noecho
      Ncurses.stdscr.intrflush(false)
      Ncurses.curs_set 0
      Ncurses.stdscr.nodelay(true)

      win = Ncurses.stdscr
      
      begin
        disp = Display.new(win)

        cards = Array.new(12) { Card.new(rand(0..2), rand(0..2), rand(1..3), rand(0..2)) }
        disp.printCards(cards)
        
        begin
          win.move(0,0)
          ch = Ncurses.getch()
          case ch
          when 113, 813
            Ncurses.curs_set(1)
            Ncurses.endwin()
            exit
          when 's'[0]
            Ncurses.stdscr.nodelay(false)
          when ' '[0]
            Ncurses.stdscr.nodelay(true)
          when 65, 67
            if(disp.cursor < cards.length - 1)
              disp.cursor += 1
              disp.printCards(cards)
            end
          when 68, 66
            if(disp.cursor > 0)
              disp.cursor -= 1
              disp.printCards(cards)
            end
          when 10
            win.addstr disp.printCard(cards)
          end
          sleep(0.050)
          win.addstr disp.printCard(cards)
        end while true

        sleep(2.5)
      ensure
        Ncurses.curs_set 1
        Ncurses.endwin
      end

      return

      start_color
      noecho

      begin
      win = Curses::Window.new(0, 0, 0, 0)
      disp = Display.new(win)

      loop do
          cards = Array.new(12) { Card.new(rand(1..3), rand(1..3), rand(1..2), rand(0..2)) }
          disp.printCards(cards)

          win << "Press any key to generate new cards. 'q' to exit."
          str = win.getch.to_s
          case str
          when 'q'
          exit 0
          end
      end
      ensure
      close_screen # this method restore our terminal's settings
      end

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

  SHAPE_BEAN = [
    "\\``\\",
    " \\##\\",
    "  |##|",
    " /##/",
    " \\##\\",
    "  \\__\\"
  ].freeze

  SHAPES = [Display::SHAPE_DIAMON, Display::SHAPE_OVAL, Display::SHAPE_BEAN].freeze

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

    cards.each.with_index(0) do |card, _c_index|
      # helpful offsets to align the card
      y_pos = row * (cardH + 1) + 1 # +1 for the space between rows
      x_pos = (col * cardW) + (col + 1 % n_cols)

      # draw full card frame at position
      FRAME.each.with_index(0) do |str, i|
        if _c_index == @cursor
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
        Display::SHAPES[card.shape].each.with_index(0) do |str, index|
          @win.move(y_pos + index + 1, x)
          @win.attrset(Ncurses.COLOR_PAIR(card.color))
          @win.addstr str.gsub('#', FILL[card.fill])
          @win.attrset(Ncurses.COLOR_PAIR(0))
        end
        $i += 1
      end

      # card position advancement
      if col + 1 >= n_cols
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