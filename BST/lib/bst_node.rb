class BSTNode
  attr_reader :value
  attr_accessor :left, :right, :parent

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end
end
