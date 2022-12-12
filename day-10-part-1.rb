# day-10-part-1

@X = 1
@total_cycle_count = 0

SIGNAL_CHECKPOINTS = [20, 60, 100, 140, 180, 220].freeze
@signal_checks = SIGNAL_CHECKPOINTS.zip(Array.new(SIGNAL_CHECKPOINTS.size, 0)).to_h

# instruction => #cycles
INSTRUCTION_SET = {
  'addx' => 2,
  'noop' => 1
}.freeze

def read_file(file)
  File.readlines(file).each do |line|
    instruction, register_value = line.split(' ')

    INSTRUCTION_SET[instruction].times do
      @total_cycle_count += 1

      if @signal_checks[@total_cycle_count]
        @signal_checks[@total_cycle_count] = @total_cycle_count * @X
      end
    end

    case instruction
    when 'addx'
      @X += register_value.to_i
    when 'noop'
      @X += 0
    end
  end
end

read_file('day-10-input.txt')

# Print answer by summing values of signal strength checkpoints
puts @signal_checks
puts @signal_checks.values.sum
