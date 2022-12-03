# day-1-part-1
# Just make a single pass, summing the calories
# for each group and keeping track of the largest
# sum encountered so far.

def read(file)
  largest_number_so_far = 0
  current_sum = 0
  File.readlines(file).each do |line|
    if line == "\n"
      largest_number_so_far = [largest_number_so_far, current_sum].max
      current_sum = 0
    else
      current_sum += line.to_i
    end
  end
  print largest_number_so_far
end

read('day-1-input.txt')
