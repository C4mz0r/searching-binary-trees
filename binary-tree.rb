require 'colorize'

class Node
	attr_accessor :value
	attr_accessor :parent
	attr_accessor :lchild
	attr_accessor :rchild
	#@root = nil

	def initialize(value, parent = nil, lchild = nil, rchild = nil)
		@value = value
		@parent = parent
		@lchild = lchild
		@rchild = rchild
	end

end

class BST
	attr_accessor :root

	def build_tree(data_array)
		@root = nil
		data_array.each do |data|
			#puts "Want to insert #{data}"
			@root = insert(@root, data)
		end	
		#@root
	end

	def insert(root, data, parent = nil)
		if !root then
			#puts "creating a new node, with #{data} and the parent is #{parent} (#{parent.value if !parent.nil?})"
			root = Node.new(data, parent)
			return root
		elsif data < root.value
			#puts "Putting value on left"
			root.lchild = insert( root.lchild, data, root )
		elsif data > root.value
			#puts "Inserting value on the right"
			root.rchild = insert( root.rchild, data, root )
		end
		root
	end

	# Returns the node which contains the target value, nil otherwise
	def breadth_first_search(target_value)
		visited = [@root]			
		queue = [@root]
		
		puts "Q is #{queue}"
		
		while ( queue.length > 0 )	

			# dequeue
			vertex = queue.shift
			puts "Dequeued #{vertex.value}"
			puts "Vertex is #{vertex}"
			return vertex if target_value == vertex.value
		
			# visit all adjacent unvisited vertexes (alphabetically), mark visited, enqueue
			if ( !vertex.lchild.nil? )
				puts "Lchild is NOT nil"
				if !visited.include?vertex.lchild
					visited << vertex.lchild
					queue << vertex.lchild
					puts "v'd and Q'd #{vertex.lchild.value}"
				end
			end
		
			if ( !vertex.rchild.nil? )
				puts "Rchild is NOT nil"
				if !visited.include?vertex.rchild
					visited << vertex.rchild
					queue << vertex.rchild
					puts "v'd and Q'd #{vertex.rchild.value}"
				end
			end

		end

		nil
	end


	def depth_first_search(target_value)
		# push the first vertex on to the stack and mark it as visited
		visited = [@root]
		stack = [@root]

		while (stack.length > 0)
			puts "Stack size = #{stack.length}"
			puts "Stack looks like:"
			stack.each do |n| puts n.value end
			#look at vertex at top of stack
			vertex = stack[-1]
			return vertex if target_value == vertex.value
			puts "Looking at #{vertex.value} to find adacent unvisiteds...."
		
			#find the adjacent unvisited (alpha) vert to it		
			if ( !vertex.lchild.nil? and !visited.include?vertex.lchild) # check the left
					# push on to stack and mark visited			
					stack << vertex.lchild
					visited << vertex.lchild
			elsif ( !vertex.rchild.nil? and !visited.include?vertex.rchild) # check the right
					# push on to stack and mark visited			
					stack << vertex.rchild
					visited << vertex.rchild
			else # there is no vertex to visit, so we pop off the stack
				puts "Popping #{stack[-1].value} off stack"
				stack.pop
			end	
			#puts "Enter to continue"
			#gets		
		end
	end

	def dfs_rec(target_value, node)
		return node if !node.nil? and target_value == node.value
		dfs_rec(target_value, node.lchild) if !node.nil?
		dfs_rec(target_value, node.rchild) if !node.nil?
	end

end

tree = BST.new
tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
#tree.build_tree([1, 7, 4, 23, 8, 9, 4, 5, 7, 9, 67, 6345, 324])
#puts Node.@root.inspect

not_found = tree.breadth_first_search(10)
puts "Tried to get non-existent item; NIL = #{not_found.nil?}".colorize(:red)

found = tree.breadth_first_search(67)
puts "#{found}; #{found.value}".colorize(:red)


not_found = tree.depth_first_search(10)
puts "Tried to get non-existent item; NIL = #{not_found.nil?}".colorize(:green)

found = tree.depth_first_search(67)
puts "#{found}; #{found.value}".colorize(:green)

not_found = tree.dfs_rec(10, tree.root)
puts "Tried to get non-existent item; NIL = #{not_found.nil?}".colorize(:yellow)

found = tree.dfs_rec(67, tree.root)
puts "#{found}; #{found.value}".colorize(:yellow)


