require_relative "heap"

class Array
  def heap_sort!
    2.upto(count).each do |size|
      BinaryMinHeap.heapify_up(self, size - 1, size)
    end

    count.downto(2).each do |size|
      self[size - 1], self[0] = self[0], self[size - 1]
      BinaryMinHeap.heapify_down(self, 0, size - 1)
    end

    self.reverse!
  end
end


# [4, 2, 1, 3, 5, 7, 8, 9
# [5, 4, 3, 2, 1]
