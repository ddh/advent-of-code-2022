# day-1-part-2
# Similar as part-1, but instead it's the sum of
# the largest three values.
# Still make a single pass, summing the calories
# for each group, but shove them into an array.
# Sort the array 

def read(file)
  sums = []

  current_sum = 0
  File.readlines(file).each do |line|
    if line == "\n"
      sums << current_sum
      current_sum = 0
    else
      current_sum += line.to_i
    end
  end
  print sums.sort[-3..-1].sum
end

read('day-1-input.txt')
