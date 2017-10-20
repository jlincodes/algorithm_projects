require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
    @length += 1
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    # last_item = @store[@length-1]
    # @store[@length-1] = nil
    @length -= 1
    # return last_item
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
    @start_idx = 0
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    shifted_item = @store[0]

    new_arr = StaticArray.new(@capacity)
    @length -= 1
    idx = 0

    while idx < @length
      new_arr[idx] = @store[idx+1]
      idx += 1
    end

    @store = new_arr
    return shifted_item
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity

    new_arr = StaticArray.new(@capacity)
    new_arr[0] = val
    idx = 0

    while idx < @length
      new_arr[idx+1] = @store[idx]
      idx += 1
    end

    @store = new_arr
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity = @capacity * 2
    old_store = @store
    new_store = StaticArray.new(@length * 2)
    count = 0
    while count < @length
      new_store[count] = @store[count]
      count += 1
    end
    @store = new_store
  end
end
