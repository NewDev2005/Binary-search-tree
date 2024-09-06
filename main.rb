require_relative 'lib/tree'
# arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
# arr = [50,30,20,40,32,34,36,70,60,65,80,75,85,21]
arr = (Array.new(15) { rand(1..100) })
p arr
tree = Tree.new(arr)
tree.eleminate_duplicate
tree.build_tree

p tree.level_order
# p tree.preorder
# p tree.postorder(tree.root)
p tree.inorder(tree.root)
p tree.postorder(tree.root)
# p tree.balanced?(tree.root)
# tree.delete(60)
# tree.delete(4)
puts "\n"
puts tree.pretty_print
for i in (1..10)
  tree.insert((rand(101..300)))
end
puts tree.pretty_print
puts tree.height
p tree.balanced?
tree.rebalance
tree.build_tree
puts tree.pretty_print
puts tree.balanced?




# x = tree.root.left_child.data
# y = tree.root.right_child.data
# tree.root.left_child.data = 12
# puts tree.pretty_print
# puts x