# day-6-part-2
# Scan with sliding window frame,
# checking if consecutive 14-letters is unique

def read(file)
  counter = 0
  uniq_chars = []
  File.readlines(file).each do |line|
    line.chars.each do |char|
      break if uniq_chars.uniq.count == 14

      uniq_chars << char
      counter += 1
      uniq_chars = uniq_chars.drop(1) if uniq_chars.length > 14
    end
  end

  # Print answer:
  print counter
end

read('day-6-input.txt')
