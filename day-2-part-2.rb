# Find the largest three

# A Rock | X==lose
# B Paper | Y==draw
# C Scissors | Z==win

def read(file)
  sum = 0
  choosings = { A: { X: "scissors", Y: "rock", Z: "paper" }, B: { X: "rock", Y: "paper", Z: "scissors" }, C: { X: "paper", Y: "scissors", Z: "rock" } }
  points = { "rock" => 1, "paper" => 2, "scissors" => 3 }
  winnings = { X: 0, Y: 3, Z: 6 }
  File.readlines(file).each do |line|
    sum += winnings[line[-2].to_sym]
    sum += points[choosings[line[0].to_sym][line[-2].to_sym]]
  end
  print sum
end

read('day-2-input.txt')
