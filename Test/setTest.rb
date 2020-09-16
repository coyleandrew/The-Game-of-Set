$LOAD_PATH << File.join(File.dirname(__FILE__), "../Model")
$LOAD_PATH << File.join(File.dirname(__FILE__), "../lib")
require "Card"
require "IsASet"

# Test case 1 for is_set?(): True
card1 = Card.new 1, 0, 2, 2
card2 = Card.new 1, 0, 2, 1
card3 = Card.new 1, 0, 2, 0

puts IsASet.a_set(card1, card2, card3)

# Test case 2 for is_set?(): False
card4 = Card.new 1, 0, 1, 2
card5 = Card.new 1, 0, 2, 2
card6 = Card.new 3, 0, 3, 2

puts IsASet.a_set(card4, card5, card6)
#---------------------------------------
#Test case 1 for sets(): True
card7 = Card.new 1, 0, 2, 2         
card8 = Card.new 2, 0, 2, 1
card9 = Card.new 1, 0, 2, 0
card10 = Card.new 1, 0, 2, 2
card11 = Card.new 1, 0, 2, 1        
card12 = Card.new 1, 0, 2, 0
card13 = Card.new 1, 0, 2, 2
card14 = Card.new 1, 0, 2, 1
card15 = Card.new 1, 0, 2, 0        
card16 = Card.new 1, 0, 2, 2
card17 = Card.new 1, 0, 2, 1
card18 = Card.new 1, 0, 2, 0

deck = [card7, card8, card9, card10, card11, card12, card13, card14,
        card15, card16, card17, card18]

puts IsASet.sets(deck).to_s