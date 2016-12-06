class PriorityQueue
  def initialize(maxsize)
    @orderedlist = Array.new()
    if maxsize < 1
      raise "maxsize must be at least 1"
    end
    @maxsize = maxsize
  end
  def add(priority,value)
    if @orderedlist.length < @maxsize or yield @orderedlist[0][0], priority
      inserted = false
      (@orderedlist.length-1).downto(0).each do |idx|
        if yield @orderedlist[idx][0], priority
          @orderedlist.insert(idx+1,[priority,value])
          inserted = true
          break
        end
      end
      if not inserted
        @orderedlist.push([priority,value])
      end
    end
    if @orderedlist.length > @maxsize
      @orderedlist.shift
    end
  end
  def each()
    @orderedlist.each do |priority,value|
      yield priority, value
    end
  end
end
