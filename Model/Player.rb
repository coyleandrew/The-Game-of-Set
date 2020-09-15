# frozen_string_literal: true
require "IsASet"
# initialize player and count the successful sets
class Player
  attr_reader :name, :sets, :score

  def initialize(player = 'Player', sets = [], score = 0)
    @name = player
    @sets = sets
    @score = score
  end

  def add?(cards)
    if IsASet.is_set cards
      @sets << cards
      return true
    end
    
    return false
  end

  def show(cards)
    "[#{cards.map(&:to_s).join("\n")}]"
  end

  def display_score
    @sets.count
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
