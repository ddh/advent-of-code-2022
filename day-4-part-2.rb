# day-4-part-2
# The idea here is to come up with logic to find the pairs
# that don't overlap, then we know how many do overlap.

def read(file)
  total_lines = 0
  not_overlap_count = 0
  File.readlines(file).each do |line|
    group_1, group_2 = line.split(",")
    group_1_first, group_1_second = group_1.split("-").map(&:to_i)
    group_2_first, group_2_second = group_2.split("-").map(&:to_i)

    # Find the groups that DON'T overlap (easier logic in my head)
    if (group_1_first < group_2_first && group_1_second < group_2_first) || (group_1_first > group_2_second && group_1_second > group_2_second)
      not_overlap_count += 1
    end
    total_lines += 1
  end

  # Print answer
  print total_lines - not_overlap_count
end

read('day-4-input.txt')
