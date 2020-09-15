require "Graphics"
require "Input"

class Board
    def initialize(window, game)
        @win = window
        @game = game
        @cursor = [0,0]
        @hand = []
    end

    def play
      @win.clear
      printCards

      while((ch = @win.getch()) != Ncurses::KEY_F1) do
        pos = @cursor

        case(ch)
        when Input::DOWN
          if pos[0] + 1 <= 1
            pos[0] += 1
          else
            pos[0] = 0
          end
  
          printCards
        when Input::UP
          if pos[0] - 1 >= 0
            pos[0] -= 1
          else
            pos[0] = 1
          end
  
          printCards
        when Input::LEFT
          if pos[1] - 1 >= 0
            pos[1] -= 1
          else
            pos[1] = 8
          end
  
          printCards
        when Input::RIGHT
          if pos[1] + 1 <= 7
            pos[1] += 1
          else
            pos[1] = 0
          end
  
          printCards
        when Input::ENTER
          index = (@cursor[0] * 8) + @cursor[1]
          card = @game.cards[index]

          if @hand.length < 3 && !@hand.include?(card)
            @hand.push @game.cards[index]
            printCards
          elsif @hand.length > 0 && @hand.include?(card)
            @hand.delete card
            printCards
          end
        when Input::ESCAPE
          return
        end
      end
    end

    def draw
        
    end

    def printCards
        @win.move(0, 0)
        cards = @game.cards
    
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

          # normal frame graphic
          frame = Graphics::UI_CARD_FRAME
          # shade for cursor
          if @hand.include?(card)
            frame = Graphics::UI_CARD_FRAME_SELECTED
          end
          
          if row == @cursor[0] && col == @cursor[1]
            @win.attrset(Ncurses.COLOR_PAIR(2))
          else
            @win.attrset(Ncurses.COLOR_PAIR(1))
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
              if row == @cursor[0] && col == @cursor[1]
                @win.attrset(Ncurses.COLOR_PAIR(card.color + 10))
              else
                @win.attrset(Ncurses.COLOR_PAIR(card.color))
              end
              @win.addstr str.gsub('#', Graphics::SHAPE_FILL[card.fill])
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
    
          
          # set the cursor past the cards, usefull when finished
          @win.move(y_pos + cardH + 1, 0)
          @win.addstr "q to quit"
          @win.clrtoeol
          Ncurses.refresh
        end
      end
end
