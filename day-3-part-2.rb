# Find common letter from three lines

@alphabet = ('a'..'z').to_a + ('A'..'Z').to_a

# a = 1, b = 2 .. Z = 52
def priority_of_letter(letter)
  @alphabet.index(letter) + 1
end

# Finds common letter across n strings, using Set#intersection
def find_common_letter(lines)
  lines[0].chars.intersection(*lines[1..-1].map(&:chars)).first
end

@lines = [] # We'll shove three lines in at a time for comparison

def read(file)
  priority_sum = 0
  line_count = 0

  File.readlines(file).each do |line|
    @lines << line

    # Every third line we'll check for the common letter
    if ((line_count + 1) % 3).zero?
      # Pass in the last three lines encountered to find the common letter
      common_letter = find_common_letter(@lines[-3..-1])

      # Add the priority value of the common letter to the running total
      priority_sum += priority_of_letter(common_letter)
    end
    line_count += 1
  end

  print priority_sum
end

read('day-3-input.txt')
