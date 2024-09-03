require_relative 'lib/tree'
# arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
arr = [50,30,20,40,32,34,36,70,60,65,80,75,85]
tree = Tree.new(arr)
tree.eleminate_duplicate
tree.build_tree

p tree.depth(70)

# tree.delete(60)
# tree.delete(4)
puts "\n"
puts tree.pretty_print


# x = tree.root.left_child.data
# y = tree.root.right_child.data
# tree.root.left_child.data = 12
# puts tree.pretty_print
# puts x