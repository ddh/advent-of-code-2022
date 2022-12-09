# day-8-part-2
# Now the elves want to scores trees by scenic views.
# A tree's scenic view is a sum of scenic views from
# four directions of the tree in question. The score
# is determined by the number of trees that are the
# same height or smaller than the current tree. Stop
# counting when you meet a tree with the same height
# or taller. Then multiply the scores from the four
# directions to get the tree's total score.

# My thoughts: Create a separate array to house the scenic
# scores. Iterate through a 2D array and calculate the scenic
# scores for each tree. Flatten the scores array, find the max.

# DEBUG: Visually print an array to console
def print_array(array)
  array.each do |row|
    print "#{row}\n"
  end
end

# Helper: Creates a 2D array from text file grid of integers
def create_array_from_input(input)
  array = []
  File.readlines(input).each do |line|
    array << line.chop.chars.map(&:to_i)
  end

  return array
end

# Helper: Returns the scenic score given a tree and
# an array of tree heights ordered from closest neighboring tree first.
def calculate_scenic_score(original_height, other_heights = [])
  scenic_score = 0
  other_heights.each do |height|
    scenic_score += 1
    break if height >= original_height
  end
  return scenic_score
end

# Tree heights above tree, in order of closest tree to given coordinates
def get_tree_heights_above(row_idx, col_idx, forest)
  [*0...row_idx].reverse.map { |i| forest[i][col_idx] }
end

# Tree heights below tree, in order of closest tree to given coordinates
def get_tree_heights_below(row_idx, col_idx, forest)
  [*row_idx + 1...forest.size].map { |i| forest[i][col_idx] }
end

# Tree heights left of tree, in order of closest tree to given coordinates
def get_tree_heights_left(row_idx, col_idx, forest)
  [*0...col_idx].reverse.map { |i| forest[row_idx][i] }
end

# Tree heights right of tree, in order of closest tree to given coordinates
def get_tree_heights_right(row_idx, col_idx, forest)
  [*col_idx + 1...forest[0].size].map { |i| forest[row_idx][i] }
end

# BEGIN PROGRAM:

# Create 2D array from input
forest = create_array_from_input('day-8-input.txt')
# print_array forest # DEBUG

# Create scenic score array
column_count = forest[0].length
row_count = forest.length
scenic_scores = row_count.times.map { column_count.times.map { 0 } }
# print_array(scenic_scores) # DEBUG

# Populate scenic score array with scores
row_count.times do |row_index|
  column_count.times do |col_index|
    height_current = forest[row_index][col_index]
    above_score = calculate_scenic_score(height_current, get_tree_heights_above(row_index, col_index, forest))
    below_score = calculate_scenic_score(height_current, get_tree_heights_below(row_index, col_index, forest))
    right_score = calculate_scenic_score(height_current, get_tree_heights_right(row_index, col_index, forest))
    left_score = calculate_scenic_score(height_current, get_tree_heights_left(row_index, col_index, forest))

    scenic_scores[row_index][col_index] = above_score * below_score * right_score * left_score
  end
end

# print_array scenic_scores # DEBUG

# Find and Print the answer
print scenic_scores.flatten.max
