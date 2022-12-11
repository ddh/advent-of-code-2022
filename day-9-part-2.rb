# day-9-part-2
# (running this file requires ruby 3.x.x)
# Same as part 1, except there's a chain
# of tails.

# My idea here is to expand on my Part 1 solution
# by making a 'Knot' class. We're basically going
# to use linked lists here to OOP us to the answer.

# Represents a point in cartesian coordinate plane
# This one is special in that two points are considered
# equal if they share same x,y.
class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    "(#{x}, #{y})"
  end

  # These allow Set to treat Points with same x,y as the same
  def eql?(other) = x == other.x && y == other.y
  def hash = [x,y].hash
end

# Our linked list. We can add knots to it.
# We tell our 'rope' to move, and it'll
# move the 'head' knot, which in turn tells
# its child to move, etc etc down to the tail.
class Rope
  attr_accessor :head, :tail

  def initialize
    @head = Knot.new(0,0)
    @tail = @head
  end

  def move(direction)
    @head.move(direction)
  end

  def add
    knot = Knot.new(@tail.x, @tail.y)
    @tail.add(knot)
    @tail = knot
  end
end

class Knot
  require 'Set'
  attr_reader :x, :y
  attr_accessor :child, :parent

  DIRECTION = {
    'R' => [1,0],
    'L' => [-1,0],
    'U' => [0,1],
    'D' => [0,-1]
  }

  def initialize(x, y)
    @x = x
    @y = y
    @visited = Set.new.add(Point.new(x, y))
  end

  def add(knot)
    @child = knot
    @child.parent = self
  end

  def location = Point.new(x,y)

  # List of Points visited
  def visited = @visited.to_a

  # As long as x,y are within +/-1 of the other x,y, then it is touching
  def touching?
    raise "This is the head" unless @parent

    ((@parent.x - 1)..(@parent.x + 1)) === x && ((@parent.y - 1)..(@parent.y + 1)) === y
  end

  # I could probably clean this up but it works.
  # If the knot has no parent, ie it is the head,
  # it can move freely without restriction.
  # Otherwise, the knot can only move if it is
  # not touching its parent knot.
  def move(direction)

    # If no parent, then it can move
    # in the given direction freely.
    if !@parent
      @x += DIRECTION[direction][0]
      @y += DIRECTION[direction][1]

    # If a child and not touching its parent,
    # it should move...
    elsif !touching?
      # When child is diagonal, it needs to move
      # in two directions to catch up with parent
      if diagonal?
        @y += @parent.y < @y ? -1 : 1
        @x += @parent.x < @x ? -1 : 1
      else
        # Otherwise, child moves along the y-axis to catch up
        if @parent.y == @y
          @x += @parent.x < @x ? -1 : 1
        end
        # Or child moves along the y-axis to catch up
        if @parent.x == @x
          @y += @parent.y < @y ? -1 : 1
        end
      end
    end

    # Keep track of visited points
    @visited.add(Point.new(@x, @y))

    # Now tell its child to move (if it can)
    @child.move(direction) if @child
  end

  private

  def diagonal?
    @x != @parent.x && @y != @parent.y
  end
end

# Start program:

# # file = 'day-9-sample-input.txt'
file = 'day-9-input.txt'

# Create a 'rope' and add enough 'knots' (knots)
# until we have 10 knots total, as per problem
rope = Rope.new
9.times { rope.add }

File.readlines(file).each do |line|
  instruction = line.split(' ')
  direction = instruction[0]
  moves = instruction[1].to_i
  moves.times { rope.move(direction) }
end

# Prints the answer!
puts rope.tail.visited.count