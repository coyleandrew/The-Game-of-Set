$LOAD_PATH << File.join(File.dirname(__FILE__), "../Model")
$LOAD_PATH << File.join(File.dirname(__FILE__), "../lib")
require "Card"
require "IsASet"

puts "Testing is_set?()"

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
puts
#---------------------------------------
puts "Testing sets()"

#Test case 1 for sets(): 
card7 = Card.new 1, 0, 1, 2         
card8 = Card.new 1, 0, 2, 1
card9 = Card.new 1, 0, 3, 0
card10 = Card.new 2, 0, 2, 2
card11 = Card.new 3, 0, 1, 1

=begin
card12 = Card.new 3, 0, 2, 0
card13 = Card.new 1, 0, 2, 2
card14 = Card.new 1, 0, 2, 1
card15 = Card.new 1, 0, 2, 0        
card16 = Card.new 1, 0, 2, 2
card17 = Card.new 1, 0, 2, 1
card18 = Card.new 1, 0, 2, 0
=end

deck = [card7, card8, card9, card10, card11]

sets = IsASet.sets(deck)

for i in 0...sets.length()
        print "Set #", i+1, "\n"
        puts  "-------"
        for j in 0...3
                print "Card #", j+1, ":\n"
                print sets[i][j].to_s, " "
                puts
        end
        puts
end
