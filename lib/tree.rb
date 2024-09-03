require_relative 'node'
# require 'pry-byebug'
class Tree 
  attr_accessor :root, :results 
  def initialize(arr,root=nil)
    self.root = root 
    @arr = arr 
    @results = []
  end

  def sort_arr(arr)
    sorted_arr = []
  return arr if arr.length == 1
    mid = (arr.length-1)/2
    left_sub_arr = sort_arr(arr[0..mid])
    right_sub_arr = sort_arr(arr[mid+1..-1])
    length = left_sub_arr.length + right_sub_arr.length
  
    until sorted_arr.length == length
     if left_sub_arr.empty? || right_sub_arr.empty?
      break
     elsif left_sub_arr.first <= right_sub_arr.first
      sorted_arr.push(left_sub_arr.shift)
     else
      sorted_arr.push(right_sub_arr.shift)
     end
    end
    return sorted_arr = sorted_arr + left_sub_arr + right_sub_arr
  end
  
  def eleminate_duplicate
    @arr = sort_arr(@arr).uniq
    @arr
  end

  def build_tree(arr=eleminate_duplicate, start=0, end_value=@arr.length-1)
   
    mid = (start + end_value)/2
    return nil if (start > end_value)

    tree_node = Node.new(arr[mid])
    tree_node.left_child = build_tree(arr,start, mid-1)
    tree_node.right_child = build_tree(arr, mid+1, end_value)

    self.root = tree_node
    self.root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(value)
    root = @root
    until root.nil?
      if value < root.data && root.left_child.nil?
        root.left_child = Node.new(value)
        break
      elsif value > root.data && root.right_child.nil?
        root.right_child = Node.new(value)
        break
      end

      if value < root.data
        root = root.left_child
      else 
        root = root.right_child
      end
    end
  end

  def delete(value)
    root = @root
    until root.nil? 
      #This will delete a leaf node 
     if !root.left_child.nil? && root.left_child.left_child.nil? && root.left_child.right_child.nil? && root.left_child.data == value 
      root.left_child = nil
      break 
     elsif !root.right_child.nil? && root.right_child.left_child.nil? && root.right_child.right_child.nil? && root.right_child.data == value 
        root.right_child = nil 
        break 
     end

     #this will delete a node with single child
     if !root.left_child.nil? && root.right_child.nil?
      if root.data == value && !root.left_child.data.nil?   
        root.data = root.left_child.data
        root.left_child = nil 
        break 
      end
     elsif root.left_child.nil? && !root.right_child.nil?
       if root.data == value && !root.right_child.data.nil?
         root.data = root.right_child.data
         root.right_child = nil 
         break
       end
     end

    #this will delete a node with both children 
    if root.data == value && !root.left_child.nil? && !root.right_child.nil? && !root.right_child.left_child.nil? 
      node = root.right_child
      until node.left_child.nil?
        node = node.left_child 
      end
      root.data = node.data 
      root.right_child.left_child = node.right_child
      break 
    elsif root.data == value && !root.left_child.nil? && !root.right_child.nil? && root.left_child.left_child.nil? && root.left_child.right_child.nil? && root.right_child.left_child.nil? && root.right_child.right_child.nil?
      root.data = root.right_child.data 
      root.right_child = nil 
      break 
    end 

      if value < root.data
        root = root.left_child
      else
        root = root.right_child
      end
    end
  end

  def find(value)
   root = @root 
   puts "root is a #{root.class}"
   until root.nil?
     if value > root.data 
       root = root.right_child 
     elsif value < root.data 
      root = root.left_child
     elsif value == root.data 
      return root 
     end
   end
  end

  def level_order
    queue = [] 
    node_data = []
    nodes = []
    root = @root 
    return if root.nil?
    queue.push(root)
    until queue.empty?
      if !queue.empty?
        current_node = queue.first 
        node_data.push(current_node.data)
        nodes.push(current_node)
      end
      if !current_node.left_child.nil?
        queue.push(current_node.left_child)
      end
      if !current_node.right_child.nil?
        queue.push(current_node.right_child)
      end
      queue.shift
    end
    if !block_given?
      return  node_data
    elsif block_given?
      nodes.each do |node|
        yield(node)
      end
    end
  end

  def preorder
    stack = []
    results = []
    node_values = []
    root = @root 
    stack.push(root)
    until stack.empty?
      current_node = stack.last
      results.push(current_node) 
      node_values.push(current_node.data)
      stack.pop 
      if !current_node.right_child.nil?
        stack.push(current_node.right_child)
      end
      if !current_node.left_child.nil?
        stack.push(current_node.left_child)
      end
    end
    if block_given?
      results.each do |node|
        yield(node)
      end
    else
     node_values
    end
  end

  def inorder(root)
    return if root.nil?
    @results.push(root)
    inorder(root.left_child)
    inorder(root.right_child)
    nodes_data = []
    if block_given?
      @results.each do |node|
        yield(node)
      end
    else
      @results.each do |node|
        nodes_data.push(node.data)
      end
      nodes_data
    end
  end

  def postorder(root)
    return if root.nil?
    postorder(root.left_child)
    postorder(root.right_child)
    puts root.data
  end

  def height(root)
  return -1 if root.nil?
  [height(root.left_child), height(root.right_child)].max + 1
  end 

  def depth(value, root=@root)
    node = find(value)
    puts node.class
    root = @root 
    return 0 if root.nil?
    return if root.left_child.data == node.data
    depth(root.left_child)
    depth(root.right_child)
    p caller.inspect
  end
end

