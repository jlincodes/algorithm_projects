class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    min = @store[0]
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    @store.pop
    self.class.heapify_down(@store, 0, &prc)
    min
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    length = count - 1
    self.class.heapify_up(@store, length, &prc)
    @store
  end

  public

  def self.child_indices(len, parent_index)
    indices = []
    first_child = (2 * parent_index) + 1
    second_child = (2 * parent_index) + 2
    indices.push(first_child) if first_child < len
    indices.push(second_child) if second_child < len
    indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    parent_index = (child_index - 1)/2
    parent_index
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    child_indices = child_indices(len, parent_idx) || []
    first_child, second_child = child_indices
    children = child_indices.map { |idx| array[idx] }

    return array if children.all? { |c| prc.call(array[parent_idx], c) <= 0 }

    smallest_child = first_child
    unless children.length == 1
      smallest_child =
        prc.call(children[0], children[1]) == -1 ? first_child : second_child
    end

    array[parent_idx], array[smallest_child] =
      array[smallest_child], array[parent_idx]
    heapify_down(array, smallest_child, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    parent_idx = parent_index(child_idx)
    child_val = array[child_idx]
    parent_val = array[parent_idx]
    return array unless prc.call(child_val, parent_val) < 0
    array[parent_idx], array[child_idx] = child_val, parent_val
    heapify_up(array, parent_idx, len, &prc)
  end
end
