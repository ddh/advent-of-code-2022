# day-7-part-1
# Traverse a directory of folders and keep track of size
# Sum up the directories that are at least of a target size

class Node
  attr_accessor :size, :children

  def initialize
    @size = 0
  end
end

TARGET_SIZE = 100_000

@total_greater_than_target_size = 0
@node_traversal = []

def read(file)
  File.readlines(file).each do |line|
    if line == "$ cd /\n"
      @node_traversal << Node.new
      next
    end

    if line == "$ ls\n"
      # no-op
      next
    end

    # If there is a file, add its size to the current directory's size total
    if line.split(' ')[0].match?(/\d/)
      print "File size: #{line.split(' ')[0].to_i}\n"
      @node_traversal.last.size += line.split(' ')[0].to_i
      next
    end

    if line.start_with?('dir ')
      # no-op
      next
    end

    if line.match?(/\$ cd [a-zA-Z]+/)
      print "$cd into #{line.split(' ').last}\n"
      @node_traversal << Node.new
    end

    if line == "$ cd ..\n"
      print "$ cd up a directory\n"
      last_visited_node = @node_traversal.pop
      print "popped node size: #{last_visited_node.size}\n"
      @node_traversal.last.size += last_visited_node.size
      if last_visited_node.size <= TARGET_SIZE
        @total_greater_than_target_size += last_visited_node.size
      end
    end
  end

  # Print answer
  print "Sum of sizes of directories with sizes greater than target size: #{@total_greater_than_target_size}"
end

read('day-7-input.txt')
