class IsASet
  ATTRIBUTES = {
      :number => ["1","2","3"],
      :shape  => ["diamond","squiggle","oval"],
      :shading => ["solid","striped","open"],
      :color => ["red","green","purple"]
  }

  def attribute_names
    ATTRIBUTES.keys
  end


  def a_set(card1,card2,card3)
    cards_array = [card1,card2,card3]
    is_set(cards_array)
  end

  def is_set(cards_array)
    attribute_names.each do |element|
      result_array = cards_array.map(&element)
      if !all_Same?(result_array)
        return false
      elsif !all_Diff?(result_array)
      return false
           end
    end
    return true
  end


  def all_Same?(array)
    array.uniq.size <= 1
  end

  def all_Diff?(array)
    array.uniq.size == array.size
  end
end
