$LOAD_PATH << File.join(File.dirname(__FILE__), "../Model")
$LOAD_PATH << File.join(File.dirname(__FILE__), "../lib")
require "Card"
require "IsASet"

card1 = Card.new 1, 0, 2, 2
card2 = Card.new 1, 0, 2, 1
card3 = Card.new 1, 0, 2, 0

puts IsASet.a_set(card1, card2, card3)

card4 = Card.new 1, 0, 1, 2
card5 = Card.new 2, 0, 2, 2
card6 = Card.new 3, 0, 3, 2

puts IsASet.a_set(card4, card5, card6)