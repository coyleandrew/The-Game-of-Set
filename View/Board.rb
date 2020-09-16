require "Graphics"
require "Input"

class Board
    def initialize(window, game, player)
        @win, @game, @player = window, game, player

        @cursor = [0,0]
        @hand = []

        # size stuff
        @cardH = Graphics::UI_CARD_FRAME.length
        @cardW = Graphics::UI_CARD_FRAME[0].length

        @message = ""

        resize
    end

    def message msg
      @message = msg
      draw_header
    end

    def draw_header
      # draw title
      @win.move(0, 0)
      @win.attrset(Ncurses.COLOR_PAIR(2))
      @win.hline(32, @winX)

      @win.move 0, 0
      @win.addstr "A Game Of Set"



      @win.move 0, (@winX - @message.length) / 2

      @win.attrset(Ncurses.COLOR_PAIR(2))
      @win.addstr @message
      @win.attrset(Ncurses.COLOR_PAIR(0))



      score = "Score[#{@player.score}]"
      @win.move 0, @winX - score.length
      @win.attrset(Ncurses.COLOR_PAIR(2))
      @win.addstr score

      @win.refresh
    end

    def resize
      @win.clear

      # rest cursor
      # TODO: Follow the resize
      @cursor = [0,0]

      # init screen size
      @winX = Ncurses.getmaxx(@win)
      @winY = Ncurses.getmaxy(@win)

      @n_cols = (@winX / (@cardW + 1)).floor
      @n_rows = (@winY / (@cardH + 1)).floor
      
      # preferr 4 rows of 4, fall back to 2 rows of 8
      if @n_rows < 4
        @rows = 2
        @cols = 6
      else
        @rows = 4
        @cols = 3
      end

      @colStart = ((@n_cols - @cols) / 2).floor
      @rowStart = (@n_rows % @rows) / 2

      printCards
    end

    def selected_card
      index = (@cursor[0] * @cols) + @cursor[1]
      return @game.cards[index]
    end

    def play
      @win.clear
      message "Use the arrow keys to navigate and enter to select a card."
      printCards
      # continue @win.getch() twice per second.
      Ncurses.halfdelay 5

      while((ch = @win.getch()) != Ncurses::KEY_F1) do
        # escape for an empty deck
        # TODO: contains set replaces @game.cards.length
        if @game.deck.length == 0 && @game.deck.length == 0
          return
        end

        pos = @cursor
        # advance time by the expect half second.
        @game.time += 0.5

        # Half second refresh cards. Has a nice side effect of animating card claims.
        printCards
        @game.deal


        case(ch)
        when Input::DOWN
          if pos[0] + 1 <= @rows - 1
            pos[0] += 1
          else
            pos[0] = 0
          end
  
          printCards
        when Input::UP
          if pos[0] - 1 >= 0
            pos[0] -= 1
          else
            pos[0] = @rows - 1
          end
  
          printCards
        when Input::LEFT
          if pos[1] - 1 >= 0
            pos[1] -= 1
          else
            pos[1] = @cols - 1
          end
  
          printCards
        when Input::RIGHT
          if pos[1] + 1 <= @cols -1
            pos[1] += 1
          else
            pos[1] = 0
          end
  
          printCards
        when Input::ENTER
          card = selected_card

          if @hand.length < 3 && !@hand.include?(card)
            @hand.push card
            printCards
          elsif @hand.length > 0 && @hand.include?(card)
            @hand.delete card
            printCards
          end

          case @hand.length
          when 3
            if @game.claim! @player, @hand
              # this is a set
              @hand.clear

              @win.clear
              message "Set found!"
              printCards
            else
              @hand.clear
              message "That's not a set. Hints?"
            end

          when 2
            message "Select one more card."
          when 1
            message "Select two more cards."
          when 0
            message "Select three cards."
          end
        when Ncurses::KEY_RESIZE
          printCards
        when Input::ESCAPE
          return
        else
          ## let the AIs do
          @game.updateAI
        end

        # use this for debugging keys
        # if ch != -1
        #   @win.move 0, 0
        #   @win.addstr ch.to_s
        # end
      end
    end

    def printCards
      draw_header
      cards = @game.cards
      @win.move 0, 0
      @win.addstr @game.deck.length.to_s

      winX = Ncurses.getmaxx(@win)
      winY = Ncurses.getmaxy(@win)

      ## resize
      if winX != @winX || winY != @winY
        resize
      end
  
      col = @colStart
      row = @rowStart

      cards.each do |card|

        # helpful offsets to align the card
        y_pos = 2 + row * (@cardH + 1) + 1 # +1 for the space between rows
        x_pos = (col * @cardW) + (col + 1 % @n_cols)

        # is this cell under the cursor?
        selected = row - @rowStart == @cursor[0] && col - @colStart == @cursor[1]
        
        # draw the card
        if card
          drawCard card, y_pos, x_pos, selected
        end
  
        # card position advancement
        if col + 1 > @colStart + @cols - 1
          col = @colStart
          row += 1
        else
          col += 1
        end
  
        
        # set the cursor past the cards, usefull when finished
        @win.move(y_pos + @cardH + 1, 0)
        @win.clrtoeol
      end

      @win.addstr "q to quit"
      Ncurses.refresh
    end

    def drawCard card, y_pos, x_pos, selected
      # normal frame graphic
      frame = Graphics::UI_CARD_FRAME
      if @hand.include?(card)
        frame = Graphics::UI_CARD_FRAME_SELECTED
      end

      if @hand.include?(card) && !selected
        @win.attrset(Ncurses.COLOR_PAIR(1))
      elsif selected
        @win.attrset(Ncurses.COLOR_PAIR(2))
      else
        @win.attrset(Ncurses.COLOR_PAIR(4))
      end
      # draw full card frame at position
      frame.each.with_index(0) do |str, i|
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
          # selected
          if selected
            @win.attrset(Ncurses.COLOR_PAIR(card.color + 10))
          else
            @win.attrset(Ncurses.COLOR_PAIR(card.color))
          end
          @win.addstr str.gsub('#', Graphics::SHAPE_FILL[card.fill])
          @win.attrset(Ncurses.COLOR_PAIR(0))
        end
        $i += 1
      end
    end
    
end
