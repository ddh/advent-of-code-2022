# day-9-part-1
# (running this file requires ruby 3.x.x)
# There is a rope with a knots on either end.
# Let's call one knot "head" and the other "tail".
# As "head" moves, "tail" will follow along if
# it is no longer touching "tail".

class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  # These allow Set to treat Points with same x,y as the same
  def eql?(other) = x == other.x && y == other.y
  def hash = [x,y].hash

end

class Tail
  require 'Set'
  attr_reader :x, :y, :head

  def initialize(x, y, head)
    @x = x
    @y = y
    @visited = Set.new.add(Point.new(x,y))
    @head = head
  end

  # List of Points visited
  def visited = @visited.to_a

  # As long as x,y are within +/-1 of the other x,y, then it is touching
  def touching?
    ((@head.x - 1)..(@head.x + 1)) === x && ((@head.y - 1)..(@head.y + 1)) === y
  end

  def move(direction, amount)
    if !touching?
      case direction
        when 'R'
          @x += 1
          @y = @head.y if diagonal?
        when 'L'
          @x -=1
          @y = @head.y if diagonal?
        when 'U'
          @x = @head.x if diagonal?
          @y += 1
        when 'D'
          @x = @head.x if diagonal?
          @y -= 1
      end

      # Keep track of visited points
      @visited.add(Point.new(@x, @y))
    end
  end

  private

  def diagonal?
    @x != @head.x && @y != @head.y
  end

end

class Head
  attr_accessor :x, :y, :tail

  def initialize(x,y)
    @x = x
    @y = y
    @tail = Tail.new(x,y, self)
  end

  # On a cartesian coordinate
  def move(direction, amount)
    amount.times do
      case direction
        when 'R'
          @x += 1
        when 'L'
          @x -= 1
        when 'U'
          @y += 1
        when 'D'
          @y -= 1
      end

      # Tell tail to move
      @tail.move(direction, amount)
    end
  end
end

# Start program:
head = Head.new(0,0)

# Feed "head" instructions from text file
# file = 'day-9-sample-input.txt'
file = 'day-9-input.txt'

File.readlines(file).each do |line|
  instruction = line.split(' ')
  head.move(instruction[0], instruction[1].to_i)
end

# Prints the answer!
puts head.tail.visited.count

