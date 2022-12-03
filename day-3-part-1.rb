# Find the common letter between two strings

@alphabet = ('a'..'z').to_a + ('A'..'Z').to_a

# a = 1, b = 2 .. Z = 52
def priority_of_letter(letter)
  @alphabet.index(letter) + 1
end

# Returns an array of two string consisting of the
# first and last half of whatever string you passed in
def split_line_in_half(line)
  line_length = line.length
  halfway_mark = line_length/2
  return line[0...halfway_mark], line[halfway_mark..-1]
end

# Split the rucksack into its first/last half strings
# Throw each letter in the first half into a dictionary (one pass)
# Iterate through second half and check if letter has already
# been encountered by using the dictionary (< one pass).
# Immediately break out if found; that is the common letter.
def read(file)
  priority_sum = 0

  File.readlines(file).each do |line|
    first, second = split_line_in_half(line)
    common_letter = (first.chars & second.chars).first

    priority_sum += priority_of_letter(common_letter)
  end

  print priority_sum
end

read('day-3-input.txt')
