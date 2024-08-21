class Node 
  include Comparable
  attr_accessor :data, :left_child, :right_child

  def <=>(another)
    data <=> another.data
  end

  def initialize(data, left_child=nil, right_child=nil)
    self.data = data
    self.left_child = left_child
    self.right_child = right_child
  end
end

