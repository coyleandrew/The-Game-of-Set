# Test file for IsASet.rb
$LOAD_PATH << File.join(File.dirname(__FILE__), "../Model")
$LOAD_PATH << File.join(File.dirname(__FILE__), "../lib")
require "Card"
require "IsASet"
require "Game"

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
puts "****************************************"
puts "Testing sets()"

#Test case 1 for sets(): No sets
card7 = Card.new 2, 2, 3, 2         
card8 = Card.new 1, 1, 3, 2
card9 = Card.new 1, 0, 2, 1
card10 = Card.new 2, 0, 2, 2
card11 = Card.new 1, 1, 1, 2
card12 = Card.new 1, 1, 1, 1
card13 = Card.new 2, 1, 3, 1
card14 = Card.new 2, 0, 3, 2
card15 = Card.new 1, 0, 2, 2        
card16 = Card.new 1, 0, 1, 1
card17 = Card.new 1, 0, 3, 2
card18 = Card.new 2, 0, 3, 1

deck = [card7, card8, card9, card10, card11, card12, card13, card14, card15, card16, card17, card18]

sets = IsASet.sets(deck)

if sets.length > 0
        for i in 0...sets.length()
                print "Set #", i+1, "\n"
                puts  "******"
                for j in 0...3
                        print "Card #", j+1, ":\n"
                        print sets[i][j].to_s, " "
                        puts
                end
                puts
        end
else
        puts "No Sets"
end

puts "---------------------------------------"

#Test case 2 for sets(): 2 sets
card19 = Card.new 0, 1, 3, 1         
card20 = Card.new 1, 1, 3, 2
card21 = Card.new 0, 1, 1, 2
card22 = Card.new 2, 0, 2, 2
card23 = Card.new 1, 1, 1, 2
card24 = Card.new 1, 1, 1, 1
card25 = Card.new 2, 0, 2, 1
card26 = Card.new 0, 0, 1, 1
card27 = Card.new 0, 0, 2, 2        
card28 = Card.new 0, 2, 3, 2
card29 = Card.new 2, 2, 2, 2
card30 = Card.new 2, 0, 3, 1

deck = [card19, card20, card21, card22, card23, card24, card25, card26, card27, card28, card29, card30]

sets = IsASet.sets(deck)

if sets.length > 0
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
else
        puts "No Sets"
end

puts "---------------------------------------"

IsASet.a_set

game = Game.new
game.newGame

puts game.sets.length