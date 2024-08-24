require_relative 'node'
# require 'pry-byebug'
class Tree 
  attr_accessor :root
  def initialize(arr,root=nil)
    self.root = root 
    @arr = arr 
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
end

