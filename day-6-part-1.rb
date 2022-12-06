# day-6-part-1
# Scan with sliding window frame,
# checking if consecutive 4-letters is unique

def read(file)
  uniq_chars = []
  File.readlines(file).each do |line|
    line.chars.each_with_index do |char, index|
      if uniq_chars.uniq.count == 4
        print index # Prints answer
        break
      end

      uniq_chars << char
      uniq_chars.slice!(0) if uniq_chars.length > 4
    end
  end
end

read('day-6-input.txt')
