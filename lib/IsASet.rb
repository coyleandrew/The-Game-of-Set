class IsASet
  ATTRIBUTES = {
      :number => [1,2,3],
      :shape  => [0,1,2],
      :fill => [0,1,2],
      :color => [0,1,2]
  }

  def self.attribute_names
    ATTRIBUTES.keys
  end

  def self.a_set(card1,card2,card3)
    cards_array = [card1,card2,card3]
    is_set(cards_array)
  end

  def self.is_set(cards_array)
    return true
    attribute_names.each do |element|
      result_array = cards_array.map(&element)
      unless all_Same?(result_array) || all_Diff?(result_array)
        return false
      end
    end
    return true
  end

  def self.all_Same?(array)
    array.uniq.size <= 1
  end

  def self.all_Diff?(array)
    array.uniq.size == array.size
  end

  def self.sets(deck)
    sets = []
    for i in 0...10
      for j in (i+1)...11
        for k in (j+1)...12
          if a_set(deck[i],deck[j],deck[k])
            cards_array = [deck[i],deck[j],deck[k]]
            sets << cards_array
          end
        end
      end
    end
    return sets
  end

end