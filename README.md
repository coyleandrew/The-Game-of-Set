# Team-Three-Project-2
The Game of Set

# Installation
Install dependencies from Gemfile:
> bundle install

Or install dependencies manually:
Install ncurses
> gem install ncurses-ruby \
> gem install scanf

# Usage
> ruby main.rb

# Objects
Common object definitions important for module interop.

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
Game setup and running state. Objects that need to invoke game behaviors should do so through the Game reference.
> Collection of AI players.
- AI
> Cards represents the cards in play. Card objects are removed from the Deck and added to Cards through the course of play.
- Cards #=> Card[]
- Deck #=> Card[]
- Difficulity #=> 0,1,2 : Easy, Medium, Difficult
> Number of AI players
- Players  #=> 0..3
- PlayerName #=> "Player 1" or player specified
> The durration since the start of play in seconds.
- Time #=> float 0...

## Player
Object for the human player and AI players.
- Name 
> Sets of cards won by the player
- Sets 
- Score

## UI
Manages the terminal state and invokes views.

###
Methods
- Message
> Displays a message on the game view.

## GameController
Behavior orchistration object. Manages the highest level of running the game