# Set up initial island parameters
water_level <- 10
coconut_trees <- 20
coconuts <- sample(5:15, coconut_trees, replace = TRUE)
player_hunger <- 0
player_health <- 5

# Define functions for game mechanics
grow_coconuts <- function() {
  coconuts <<- coconuts + rnorm(coconut_trees, mean = 0.5, sd = 0.2)
  coconuts[coconuts < 0] <<- 0 # make sure coconuts don't go below zero
}

search_for_water <- function() {
  water_found <<- rbinom(1, 10, 0.5)
  water_level <<- min(10, water_level + water_found)
  cat(sprintf("You found %d units of water.\n", water_found))
}

eat_coconut <- function() {
  coconut_eaten <<- sample(5:15, 1)
  player_hunger <<- max(0, player_hunger - coconut_eaten)
  coconuts <<- coconuts - coconut_eaten
  coconuts[coconuts < 0] <<- 0 # make sure coconuts don't go below zero
  cat(sprintf("You ate %d coconuts.\n", coconut_eaten))
}

check_game_over <- function() {
  if (player_health <= 0 || player_hunger >= 30 || water_level <= 0) {
    cat("Game over - you did not survive :(\n")
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

# Start the game loop
while (TRUE) {
  # Print current state of island and player
  cat("Current state of island:\n")
  cat(sprintf("Water level: %d\n", water_level))
  cat(sprintf("Number of coconut trees: %d\n", coconut_trees))
  cat(sprintf("Number of coconuts: %d\n", sum(coconuts)))
  cat(sprintf("Number of healthy coconut trees: %d\n", sum(coconuts >= 5)))
  cat(sprintf("Number of sick coconut trees: %d\n", sum(coconuts < 5)))
  cat("\n")
  cat("Current state of player:\n")
  cat(sprintf("Player health: %d\n", player_health))
  cat(sprintf("Player hunger: %d\n", player_hunger))
  
  # Get user input
  user_input <- readline(prompt = "What would you like to do? (grow, search, eat, quit) ")
  
  # Execute user's choice
  if (user_input == "grow") {
    grow_coconuts()
  }
  else if (user_input == "search") {
    search_for_water()
  }
  else if (user_input == "eat") {
    eat_coconut()
  }
  else if (user_input == "quit") {
    break
  }
  
  # Update player hunger and health
  player_hunger <<- player_hunger + 1
  player_health <<- player_health - sum(coconuts == 0)
  water_level <<- water_level - 1
  
  # Check if game is over
  if (check_game_over()) {
    break
  }
}
