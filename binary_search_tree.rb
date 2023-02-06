class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def has_left?
    !@left.nil?
  end

  def has_right?
    !@right.nil?
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  attr_accessor :root

  def self.clean_arr(arr)
    sorted = arr.uniq.sort
  end

  def build_tree(arr, s_idx = 0, e_idx = arr.length - 1) #[1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345]
    return nil if s_idx > e_idx

    mid = (s_idx + e_idx) / 2
    root = Node.new(arr[mid]) #8, 4, 1
    root.left = build_tree(arr, s_idx, mid - 1)
    root.right = build_tree(arr, mid + 1, e_idx)

    @root = root
  end

  def insert(node = @root, value)
    if value > node.data
      node.right ? insert(node.right, value) : node.right = Node.new(value)
    else
      node.left ? insert(node.left, value) : node.left = Node.new(value)
    end
  end

  def minValueNode(node)
    current = node

    while current.left.nil?
      current = current.left
    end

    current
  end

  def delete(node = @root, value)
    if node.nil?
      return node
    end

    if value < node.data
      node.left = delete(node.left, value)
    elsif value > node.data
      node.right = delete(node.right, value)
    else
      if node.left.nil?
        temp = node.right
        node = nil
        return temp
      elsif node.right.nil?
        temp = node.left
        node = nil
        return temp
      end

      temp = minValueNode(node.right)
      node.data = temp.data
      node.right = delete(node.right, temp.data)
    end

    node
  end

  def find(node = @root, value)
    if node.data == value
      return node
    elsif node.has_left?
      find(node.left, value)
    elsif node.has_right?
      find(node.right, value)
    else
      return "No node contains this value"
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

my_tree = Tree.new()
my_tree.build_tree(Tree.clean_arr([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]))