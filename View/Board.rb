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

      # init screen size
      @winX = Ncurses.getmaxx(@win)
      @winY = Ncurses.getmaxy(@win)

      @n_cols = (@winX / (@cardW + 1)).floor
      @n_rows = (@winY / (@cardH + 1)).floor
      
      # wide
      if @n_rows < 4
        @rows = 2
      else
        @rows = 4
      end

      # depends on the number of cards
      # rows to float because integer division produces ints
      @cols = (@game.cards.length / @rows.to_f).ceil

      # centering offset
      @colStart = ((@n_cols - @cols) / 2).floor
      @rowStart = (@n_rows % @rows) / 2

      printCards
    end

    def selected_card
      index = (@cursor[0] * @cols) + @cursor[1]
      return @game.cards[index]
    end

    # special handeling when the player needs to acknowledge a card change event
    # prime candidate for block args
    def deal_prompt message, highlights = [], ai = nil
      modal "#{message} Press any key to draw.", highlights, ai

      deal_more_cards
    end

    # generate some cards and resize for it
    def deal_more_cards
      @game.deal
      resize
      printCards
    end

    def modal message, highlights = [], ai = nil
      # remove the cursor, but save it
      cursor, @cursor = @cursor, nil
      printCards highlights, ai

      # Show the message and halt the game
      message message
      while(ch = @win.getch()) do
        if ch != Input::NONE
          break
        end
      end

      # put the cursor back
      @cursor = cursor
      message ""
      printCards highlights, ai
    end


    def play
      @win.clear
      message "Use the arrow keys to navigate and enter to select a card."
      printCards
      # continue @win.getch() twice per second.
      
      while((ch = @win.getch()) != Ncurses::KEY_F1) do
        # game over condition
        if @game.deck.length == 0 && @game.sets.none?
          modal "Game over. Press any key to continue."
          return
        end

        # deal more for no sets
        if @game.deck.length > 0 && @game.sets.none?
          deal_prompt "No sets!"
          next
        end

        pos = @cursor
        # advance time by the expect half second.
        @game.time += 0.1

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
              deal_prompt "A Set!"
            else
              modal "Oops, that's not a set. Press any key to continue."
              @hand.clear
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
        when Input::HINT
          #TODO: look at @game.sets for all sets
          #TODO: inspect @hand for selected cards
          #TODO: push an appropiate card into @hand
          #TODO: Move @cursor[x,y]

          # play the game for me hints
          # also requires hand by empty to start, breaks if you have a hand already

          if @hand.length < 3
            # select first, makes it possible to not select the thrid card. This matters because the player needs to do it.
            card = @game.sets.first[@hand.length]

            # moves the highlight over the card
            @cursor = card_position card
            
            # auto fill the first 2. Is as if selecting it
            if @hand.length < 2
              @hand.push card
            end
          end

          # update the UI
          printCards
        else
          #give the ai a turn
          ai_turn
        end

        # use this for debugging keys
        # if ch != -1
        #   @win.move 0, 0
        #   @win.addstr ch.to_s
        # end
      end
    end

    def ai_turn
      if @game.AI.none?
        return
      end

      ## give a random AI a turn. This slightly keeps the AIs from looking like clones
      ai = @game.AI.sample
      i = @game.AI.index ai
      
      set = @game.updateAI ai
      if set
        # the ai claimed a card, draw this for the user
        
        # make the player accpet it if not on impossible mode
        modal "#{ai.name} found a set! Press any key to continue.", set, i

        # give the cards to the AI
        @game.claim! ai, set

        # draw the board with the blanks for a half second
        printCards
        sleep 0.5

        deal_more_cards
      end
    end

    def card_position card
      index = @game.cards.index card
      return [(index / @cols), (index % @cols)]
    end

    # print the cards,
    # highlight will draw a special color behind those cards.
    def printCards (highlights = [], ai = nil)
      draw_header
      cards = @game.cards
      @win.move 1, 0
      @win.addstr "Deck:[#{@game.deck.length.to_s}] Cards[#{@game.cards.length.to_s}] Sets:[#{@game.sets.length.to_s}]"

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
        selected = @cursor && row - @rowStart == @cursor[0] && col - @colStart == @cursor[1]
        
        # draw the card
        drawCard card, y_pos, x_pos, selected, highlights.include?(card) ? ai : nil
  
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

      @win.addstr "q to quit, h for hints"
      Ncurses.refresh
    end

    def drawCard card, y_pos, x_pos, selected, highlight = nil

      # pick frame graphic
      if !card
        frame = Graphics::UI_CARD_EMPTY
      elsif @hand.include?(card)
        frame = Graphics::UI_CARD_FRAME_SELECTED
      else
        frame = Graphics::UI_CARD_FRAME
      end
      
      if(highlight)
        @win.attrset(Ncurses.COLOR_PAIR(card.color + 20 + (10 * highlight)))
      elsif @hand.include?(card) && !selected
        @win.attrset(Ncurses.COLOR_PAIR(1))
      elsif selected
        @win.attrset(Ncurses.COLOR_PAIR(2))
      else
        @win.attrset(Ncurses.COLOR_PAIR(4))
      end

      # draw card frame at position
      frame.each.with_index(0) do |str, i|
        @win.move(y_pos + i, x_pos)
        @win.addstr str
      end

      # no card face to draw
      if !card
        return
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
          if highlight != nil
            @win.attrset(Ncurses.COLOR_PAIR(card.color + 20 + (10 * highlight)))
          elsif selected
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
