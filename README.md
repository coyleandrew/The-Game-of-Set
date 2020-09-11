# Team-Three-Project-2
The Game of Set

# Installation
Install curses
> gem install curses

Run the app
> ruby main.rb
`

# Objects
Common object definitions important for module interop.

> Some adjustments will be needed to accomidate multiple players, i.e. the AI players.

## Card
- Shape #=> int 0,1,2
    - 0 Diamond
    - 1 Oval
    - 2 Squiggle
- Color #=> int 0,1,2
    - 0 Red
    - 1 Green
    - 2 Purple
- Number #=> int 1,2,3
- Shading #=> int 1,2,3
    - 0 Solid
    - 1 Striped
    - 2 Outlined

## Game
> The durration since the start of play.
- Time #=> float 0...
- Deck #=> Card[]
> Represents the cards in play. Cards are moved from the Desk to the Board through the course of play.
- Board #=> Card[]

## UI
- Score #=> int 0...
- Game #=> Game
> Represents the collection of sets of 3 cards won by the player.
- Won #=> Card[][]