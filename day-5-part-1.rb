# day-5-part-1
# Your plain old stack problem.
# Push and pop until you get the answer.

# Hardcode the stacks, since there aren't too many from input file
@stacks = {
  1 => %w[r n p g],
  2 => %w[t j b l c s v h],
  3 => %w[t d b m n l],
  4 => %w[r v p s b],
  5 => %w[g c q s w m v h],
  6 => %w[w q s c d b j],
  7 => %w[f q l],
  8 => %w[w m h t d l f v],
  9 => %w[l p b v m j f]
}

def read(file)
  File.readlines(file).each do |line|
    # Skip over the crate legend, since I've hardcoded them above in a global.
    next unless line.include?('move')

    # Parse the instruction line
    qty, source, destination = line.delete('^0-9 ').split(' ').map(&:to_i)

    # Pop the crate from source stack and push onto destination stack
    qty.times { @stacks[destination].push(@stacks[source].pop) }
  end

  # Print answer:
  @stacks.each_value { |v| print v[-1] }
end

read('day-5-input.txt')
