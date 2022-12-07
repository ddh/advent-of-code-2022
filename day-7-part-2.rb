# day-7-part-2
# Traverse a directory of folders and keep track of size
# Part 2 asks to find the smallest directory to delete
# that would satisfy a space requirement.

class Node
  attr_accessor :size, :children

  def initialize
    @size = 0
  end
end

TARGET_SIZE           = 100_000
TOTAL_DISK_SPACE      = 70_000_000
REQUIRED_UNUSED_SPACE = 30_000_000

@node_traversal = []
@node_sizes = []

def read(file)
  File.readlines(file).each do |line|
    if line == "$ cd /\n"
      @node_traversal << Node.new
      next
    end

    # '$ ls' is a no-op
    if line == "$ ls\n"
      next
    end

    # If there is a file, add its size to the current directory's size total
    if line.split(' ')[0].match?(/\d/)
      print "File size: #{line.split(' ')[0].to_i}\n"
      @node_traversal.last.size += line.split(' ')[0].to_i
    end

    # 'dir ' is a no-op
    if line.start_with?('dir ')
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

      @node_sizes << last_visited_node.size
      next
    end
  end

  # Pop off the remaining directories and store their sizes
  while @node_traversal.size > 1
    print "Processing remaining node! Size: #{@node_traversal.size}\n"
    last_visited_node = @node_traversal.pop
    print "Size: #{last_visited_node.size}\n"
    @node_traversal.last.size += last_visited_node.size
    @node_sizes << last_visited_node.size
  end

  # The total size used from root is the last element in:
  print "Total size of root: #{@node_traversal.last.size}\n"

  # Subtract the total directory size used from total disk space
  # to find the size needed to free up
  used_space = @node_traversal.first.size
  print "Used space: #{used_space}\n"

  free_space = TOTAL_DISK_SPACE - used_space
  print "Free space: #{free_space}\n"

  space_needed = REQUIRED_UNUSED_SPACE - free_space
  print "Space needed: #{space_needed}\n"

  # Now sort the stored sizes and find the directory with that meets the min
  # required free space upon deletion
  @node_sizes.select! { |size| size >= space_needed }
  print "Directory of size #{@node_sizes.sort!.first} should be deleted"
end

read('day-7-input.txt')
