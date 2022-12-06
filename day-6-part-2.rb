# day-6-part-2
# Scan with sliding window frame,
# checking if consecutive 14-letters is unique

def read(file)
  uniq_chars = []
  File.readlines(file).each do |line|
    line.chars.each_with_index do |char, index|
      if uniq_chars.uniq.count == 14
        print index # Prints answer
        break
      end

      uniq_chars << char
      uniq_chars.slice!(0) if uniq_chars.length > 14
    end
  end
end

read('day-6-input.txt')
