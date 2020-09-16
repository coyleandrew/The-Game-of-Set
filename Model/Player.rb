# frozen_string_literal: true
require "IsASet"

# initialize player and count the successful sets
class Player
  attr_reader :name, :sets, :score

  def initialize(name)
    @name = name
    @sets = []
    @score = 0
  end

  def add(cards)
      @sets << cards
  end

  def score
    @sets.count
  end
end
