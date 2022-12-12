# day-10-part-2

@X = 1 # Represents the middle position of a sprite that is 3-pixels wide
@total_cycle_count = 0

# instruction => #cycles
INSTRUCTION_SET = {
  'addx' => 2,
  'noop' => 1
}.freeze

HEIGHT = 6
WIDTH = 40
@crt_matrix = HEIGHT.times.map { Array.new(WIDTH, '.') }


def read_file(file)
  File.readlines(file).each do |line|
    instruction, register_value = line.split(' ')

    INSTRUCTION_SET[instruction].times do
      @total_cycle_count += 1
      draw_pixel
    end

    case instruction
    when 'addx'
      @X += register_value.to_i
    when 'noop'
      @X += 0
    end
  end
end

def draw_pixel
  row = @total_cycle_count / WIDTH
  column = @total_cycle_count % WIDTH - 1
  @crt_matrix[row][column] = '█' if ((column - 1)..(column + 1)) === @X
end

def print_crt_screen(matrix)
  matrix.each do |row|
    print "#{row.join}\n"
  end
end

read_file('day-10-input.txt')

# Print answer by summing values of signal strength checkpoints
print_crt_screen(@crt_matrix)

# Notes on my solution:
# The "U" at the end is kinda wonky...
# suggesting that something is off.
# But the solution was accepted!
# ███....██.████.███..█..█.███..████.█..█.
# █..█....█.█....█..█.█..█.█..█.█....█..██
# ███.....█.███..█..█.████.█..█.███..█..█.
# █..█....█.█....███..█..█.███..█....█..██
# █..█.█..█.█....█.█..█..█.█.█..█....█..██
# ███...██..█....█..█.█..█.█..█.█.....██.█
