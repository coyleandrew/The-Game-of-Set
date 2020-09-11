# app.rb
$LOAD_PATH << File.join(File.dirname(__FILE__), "Model")
# I do not know the convention for handeling includes
require "UI"

puts "Booting the game"
# Initialize UI
UI.new

# TODO: Initialize game state

loop do
    # TODO: Capture inputs
    # TODO: Process inputs as game behavior

    # Game doesn't exist yet, just exit.
    return
end