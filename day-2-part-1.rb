# Find the largest three

# A Rock | X Rock
# B Paper | Y Paper
# C Scissors | Z Scissors

# { A: { X: 3, Y: 0, Z: 6 }, B: { X: 6, Y: 3, Z: 0 }, C: { X: 0, Y: 6, Z: 3 } }

def read(file)
  sum = 0
  winnings = { A: { X: 3, Y: 6, Z: 0 }, B: { X: 0, Y: 3, Z: 6 }, C: { X: 6, Y: 0, Z: 3 } }
  choosings = { X: 1, Y: 2, Z: 3 }
  File.readlines(file).each do |line|
    sum += choosings[line[-2].to_sym]
    sum += winnings[line[0].to_sym][line[-2].to_sym]
  end
  print sum
end

read('day-2-input.txt')
