require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(@start_idx + index) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    last_item = @store[(@start_idx + @length - 1) % @capacity]
    @store[(@start_idx + @length - 1) % @capacity] = nil
    @length -= 1
    last_item
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @length += 1
    @store[(@start_idx + @length - 1) % @capacity] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    shifted_item = @store[@start_idx]
    @store[@start_idx] = nil
    @length -= 1
    @start_idx = (@start_idx + 1) % capacity
    shifted_item
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % capacity
    @store[@start_idx] = val
    @length += 1
    @store
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length
  end

  def resize!
    new_capacity = @capacity * 2
    new_store = StaticArray.new(new_capacity)
    @length.times { |idx| new_store[idx] = @store[(@start_idx + idx) % @capacity]}
    @store = new_store
    @capacity = new_capacity
    @start_idx = 0
  end
end
