# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root == nil
      @root = BSTNode.new(value)
      return @root
    end

    if value <= @root.value
      add_value_to_left(value, @root)
    else
      add_value_to_right(value, @root)
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    if tree_node.value == value
      tree_node
    elsif value < tree_node.value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    target_node = find(value)

    if no_children?(target_node) && @root.value == value
      @root = nil
    elsif no_children?(target_node)
      simple_erase(target_node)
    elsif one_child?(target_node)
      one_child_promotion(target_node)
    else
      two_children_promotion(target_node)
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil? || (tree_node.left.nil? && tree_node.right.nil?)

    left = 0
    right = 0

    if tree_node.left && tree_node.right.nil?
      left += 1
      left += depth(tree_node.left)
    elsif tree_node.right && tree_node.left.nil?
      right += 1
      right += depth(tree_node.right)
    else
      left += 1
      right += 1
      left += depth(tree_node.left)
      right += depth(tree_node.right)
    end

    left >= right ? left : right
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:

  def add_value_to_left(value, node)
      if node.left.nil?
        new_node = BSTNode.new(value)
        node.left = new_node
        new_node.parent = node
      elsif value <= node.left.value
        add_value_to_left(value, node.left)
      else
        add_value_to_right(value, node.left)
      end
    end

    def add_value_to_right(value, node)
      if node.right.nil?
        new_node = BSTNode.new(value)
        node.right = new_node
        new_node.parent = node
      elsif value <= node.right.value
        add_value_to_left(value, node.right)
      else
        add_value_to_right(value, node.right)
      end
    end

  def no_children?(target_node)
      target_node.left.nil? && target_node.right.nil?
  end

  def one_child?(target_node)
    (target_node.left && target_node.right.nil?) ||
      (target_node.right && target_node.left.nil?)
  end

  def simple_erase(target_node)
    parent_node = target_node.parent
    parent_node.left = nil if parent_node.left == target_node
    parent_node.right = nil if parent_node.right == target_node
  end

  def one_child_promotion(target_node)
    child_node = target_node.right ? target_node.right : target_node.left
    assign_new_parent_child_relationship(target_node, child_node)
  end

  def two_children_promotion(target_node)
    max_node_in_left = maximum(target_node.left)

    one_child_promotion(max_node_in_left)

    target_node.left.parent = max_node_in_left
    target_node.right.parent = max_node_in_left

    max_node_in_left.left = target_node.left
    max_node_in_left.right = target_node.right

    assign_new_parent_child_relationship(target_node, max_node_in_left)
  end

  def assign_new_parent_child_relationship(target_node, new_child_node)
    parent_node = target_node.parent

    if parent_node.left == target_node
      parent_node.left = new_child_node
    else
      parent_node.right = new_child_node
    end

    new_child_node.parent = parent_node
  end

end
