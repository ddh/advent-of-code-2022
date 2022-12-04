# Check if a group is fully encompassed by another  

def read(file)
  fully_contained_count = 0
  File.readlines(file).each do |line|
    group_1, group_2 = line.split(',')
    group_1_first, group_1_second = group_1.split('-').map(&:to_i)
    group_2_first, group_2_second = group_2.split('-').map(&:to_i)

    # Checking two scenarios where one group encompasses the other
    if (group_1_first <= group_2_first && group_1_second >= group_2_second) || (group_1_first >= group_2_first && group_1_second <= group_2_second)
      fully_contained_count += 1
    end
  end

  # Print answer
  print fully_contained_count
end

read('day-4-input.txt')
