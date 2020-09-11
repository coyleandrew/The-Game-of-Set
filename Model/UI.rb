require 'curses'
include Curses

class UI
        
    def initialize
        init_screen
        start_color
        noecho

        begin
        win = Curses::Window.new(0, 0, 0, 0)
        disp = Display.new(win)

        loop do
            cards = Array.new(12) { Card.new(rand(1..3), rand(1..3), rand(0..2), rand(0..2)) }
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
    '|``````````````````|',
    '|                  |',
    '|                  |',
    '|                  |',
    '|                  |',
    '|                  |',
    '|                  |',
    '|__________________|'
  ].freeze

  SHAPE_DIAMON = [
    '  /\\',
    ' /##\\',
    '/####\\',
    '\\####/',
    ' \\##/',
    '  \\/'
  ].freeze

  SHAPE_OVAL = [
    '  /\\',
    ' |##|',
    ' |##|',
    ' |##|',
    ' |##|',
    '  \\/'
  ].freeze

  SHAPE_BEAN = [
    '\\``\\',
    ' \\##\\',
    '  |##|',
    ' /##/',
    ' \\##\\',
    '  \\__\\'
  ].freeze

  SHAPES = [Display::SHAPE_DIAMON, Display::SHAPE_OVAL, Display::SHAPE_BEAN].freeze

  FILL = [' ', '-', '#'].freeze

  def initialize(win)
    @win = win

    init_pair(1, 1, 0)
    init_pair(2, 2, 0)
    init_pair(3, 13, 0)
  end

  def printCards(cards)
    @win.clear
    @win.setpos(0, 0)

    cardH = 8
    cardW = 20
    n_cols = (@win.maxx / (cardW + 1)).floor

    col = 0
    row = 0

    cards.each.with_index(0) do |card, _c_index|
      # helpful offsets to align the card
      y_pos = row * (cardH + 1) + 1 # +1 for the space between rows
      x_pos = (col * cardW) + (col + 1 % n_cols)

      # draw full card frame at position
      FRAME.each.with_index(0) do |str, i|
        @win.setpos(y_pos + i, x_pos)
        @win << str
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
          @win.setpos(y_pos + index + 1, x)
          @win.attron(color_pair(card.color)) do
            @win << str.gsub('#', FILL[card.fill])
          end
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

      # set the cursor past the cards, usefull when finished
      @win.setpos(y_pos + cardH + 1, 0)
    end
  end
end

class Card
  def initialize(c, n, s, f)
    @color = c
    @number = n
    @shape = s
    @fill = f
  end

  attr_reader :shape

  attr_reader :number

  attr_reader :color

  attr_reader :fill
end