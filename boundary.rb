# frozen_string_literal: true

class Node
    attr_accessor :val, :left, :right
    def initialize(val = 0, _left = nil, _right=nil)
        @val = val
        @next =  _left
        @right = _right
    end
end
# @param {ListNode} head
# @param {Integer} left
# @param {Integer} right
# @return {ListNode}
class Boundary
  def is_leaf(root)
    root.left.nil? && root.right.nil?
  end
  def leaves(root, res)
    return if root.nil?
    res << root.val if is_leaf(root)
    leaves(root.left, res)
    leaves(root.right, res)
  end


  def left_val(root, res)
    root = root.next
    while (root)
      res << root.val if !is_leaf(root)
      if root.left
        left_val(root.left, res)
      else
        left_val(root.right, res)
      end
    end
  end

  def right_val(root, res)
    root = root.next
    stack = []
    while(root)
      stack << root.val if !is_leaf(root)
      if root.right
        right_val(root.right, res)
      else
        right_val(root.left, res)
      end
      while(stack.size > 0)
        res << stack.pop
      end
    end
  end
  def boundary_val(root, res)
    return res if  root.nil?
    res << root.val if !is_leaf(root)
    left_val(root, res)
    leaves(root, res)
    right_val(root, res)
  end
end


root = Node.new(20)
root.left = Node.new(8)
root.left.left = Node.new(4)
root.left.right = Node.new(12)
root.left.right.left = Node.new(10)
root.left.right.right = Node.new(14)
root.right = Node.new(22)
root.right.right = Node.new(25)
res = []
Boundary.new.boundary_val(root, res)
print res
