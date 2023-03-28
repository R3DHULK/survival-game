# Define player class
class Player
  attr_accessor :health, :hunger, :thirst, :location

  def initialize(location)
    @health = 100
    @hunger = 0
    @thirst = 0
    @location = location
  end

  def move(direction)
    case direction
    when "north"
      @location[0] += 1
    when "south"
      @location[0] -= 1
    when "east"
      @location[1] += 1
    when "west"
      @location[1] -= 1
    end
    @hunger += 5
    @thirst += 5
  end

  def rest
    @health += 10
    @hunger += 5
    @thirst += 5
  end

  def eat
    @health += 10
    @hunger = 0
  end

  def drink
    @health += 10
    @thirst = 0
  end

  def status
    puts "Health: #{@health}"
    puts "Hunger: #{@hunger}"
    puts "Thirst: #{@thirst}"
    puts "Location: #{@location}"
  end
end

# Define game loop
loop do
  # Initialize game state
  player = Player.new([0, 0])

  # Play game
  until player.health <= 0
    # Prompt user for action
    puts "What would you like to do? (move, rest, eat, drink, status)"
    action = gets.chomp.downcase

    # Perform action
    case action
    when "move"
      puts "Which direction? (north, south, east, west)"
      direction = gets.chomp.downcase
      player.move(direction)
    when "rest"
      player.rest
    when "eat"
      player.eat
    when "drink"
      player.drink
    when "status"
      player.status
    end

    # Check for game over conditions
    if player.hunger >= 100
      puts "You died of starvation."
      break
    elsif player.thirst >= 100
      puts "You died of dehydration."
      break
    end
  end

  # Print game over message
  puts "Game over."
  print "Play again? (y/n): "
  play_again = gets.chomp.downcase
  break if play_again == "n"
end
