# frozen_string_literal: true

# initialize player and count the successful sets
class Player
  attr_reader :name, :sets, :score

  def initialize(player = 'Player', sets = [], score = 0)
    @name = player
    @sets = sets
    @score = score
  end

  def add(cards)
    @sets << cards if       # wait for is_a_set to check condition
    puts "\n#{@name} chooses the set of #{show(cards)}."
  end

  def show(cards)
    "[#{cards.map(&:to_s).join("\n")}]"
  end

  def display_score
    score = @sets.count
    puts "#{@name} Sets: #{score}"
  end

  def win_lose(other_player)
    if sets.count > other_player.sets.count
      puts "\n#{@name} wins!"
    elsif sets.count < other_player.sets.count
      puts "\n#{other_player.name} wins!"
    else
      puts "\n Have the same score."
    end
  end
end
