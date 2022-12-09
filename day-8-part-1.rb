# day-8-part-1
# Given a grid of trees and their heights, each tree has a visibility property
# that is determined if a tree is at least visible from one direction.
# The problem asks us to find how many trees are visible.

# Thoughts: We can take a 2D array and determine the visibilities approaching
# from the left. Then we store those visibilities and rotate the array and repeat.
# In the end, we do some matrix math and 'AND' across all 4 2D arrays, after rotating
# them back so they're in the proper orientation. If we set TRUE to hidden trees
# and FALSE as visible trees, we can determine a tree is hidden IF AND ONLY IF it is
# hidden, ie TRUE, from all four sides.

# Helper: Rotates array clockwise 90 degrees
def rotate_array(array)
  array.transpose.map(&:reverse)
end

# Debugging: Visually print an array to console
def print_array(array)
  array.each do |row|
    print "#{row}\n"
  end
end

# Helper: Creates a 2D array from text file grid of integers
def create_array_from_input(input)
  forest = []
  File.readlines(input).each do |line|
    forest << line.chop.chars.map(&:to_i)
  end

  return forest
end

# Helper: Creates an array of the same mxn as given array,
# where elements are the tree visibility looking from the left,
# that is working from top to bottom, left to right in the array.
def produce_visibility_map(forest_array)
  column_count = forest_array[0].length
  row_count = forest_array.length
  visibility_map = row_count.times.map { column_count.times.map { true } }

  row_count.times do |row_index|
    largest_tree_viewed = -1 # Prime the check
    column_count.times do |col_index|
      tree_size = forest_array[row_index][col_index]
      if largest_tree_viewed < tree_size
        largest_tree_viewed = tree_size
        visibility_map[row_index][col_index] &= false # visible
      else
        visibility_map[row_index][col_index] &= true # hidden
      end
    end
  end

  return visibility_map
end

# Start program:

# Create 2D array of the forest
forest = create_array_from_input('day-8-input.txt')
# Uncomment this to test with the smaller sample input
# forest = create_array_from_input('day-8-sample-input.txt')

# Visibility map looking from left
left = produce_visibility_map(forest)

# Visibility map looking from bottom
bottom = produce_visibility_map(rotate_array(forest))
bottom = rotate_array(rotate_array(rotate_array(bottom)))

# Visibility map looking from right
right = produce_visibility_map(rotate_array(rotate_array(forest)))
right = rotate_array(rotate_array(right))

# Visibility map looking from top
top = produce_visibility_map(rotate_array(rotate_array(rotate_array(forest))))
top = rotate_array(top)

# Determine final visibility map by &&'ing each tree's visibility
# from the different directions. The visibility maps have been
# rotated above so they're all oriented with the original forest[]
column_count = forest[0].length
row_count = forest.length
final_visibility_map = row_count.times.map { column_count.times.map { true } }

row_count.times do |row_index|
  column_count.times do |col_index|
    final_visibility_map[row_index][col_index] =
      left[row_index][col_index] &&
      bottom[row_index][col_index] &&
      right[row_index][col_index] &&
      top[row_index][col_index]
  end
end

# Tally shows the counts for true (hidden trees) and false (visible trees)
# [false, xxx]
# [true, xxx]
print_array(final_visibility_map.flatten.tally)
