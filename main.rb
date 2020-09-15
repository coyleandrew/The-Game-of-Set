# app.rb
# I do not know the convention for handeling includes
$LOAD_PATH << File.join(File.dirname(__FILE__), "Model")
$LOAD_PATH << File.join(File.dirname(__FILE__), "Controller")
$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")

require "UI"
require "Game"
require "GameController"

puts "Booting the game"

begin
    # Initialize all the game stuff
    ui = UI.new
    game = Game.new
    controller = GameController.new game, ui

    loop do
        controller.run

        # TODO: Process inputs as game behavior

        # Game doesn't exist yet, just exit.
        return
    end
ensure
    Ncurses.curs_set 1
    Ncurses.endwin
end
