# Set up initial desert parameters
water_level <- 10
cactus_plants <- 20
cactus_heights <- sample(5:15, cactus_plants, replace = TRUE)
player_hunger <- 0
player_health <- 5

# Define functions for game mechanics
grow_cacti <- function() {
  cactus_heights <<- cactus_heights + rnorm(cactus_plants, mean = 0.5, sd = 0.2)
  cactus_heights[cactus_heights < 0] <<- 0 # make sure heights don't go below zero
}

search_for_water <- function() {
  water_found <<- rbinom(1, 10, 0.5)
  water_level <<- min(10, water_level + water_found)
  cat(sprintf("You found %d units of water.\n", water_found))
}

eat_cactus <- function() {
  cactus_eaten <<- sample(5:15, 1)
  player_hunger <<- max(0, player_hunger - cactus_eaten)
  cactus_heights <<- cactus_heights - cactus_eaten
  cactus_heights[cactus_heights < 0] <<- 0 # make sure heights don't go below zero
  cat(sprintf("You ate %d units of cactus.\n", cactus_eaten))
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
  # Print current state of desert and player
  cat("Current state of desert:\n")
  cat(sprintf("Water level: %d\n", water_level))
  cat(sprintf("Number of cactus plants: %d\n", cactus_plants))
  cat(sprintf("Average cactus height: %.1f\n", mean(cactus_heights)))
  cat(sprintf("Number of healthy cactus plants: %d\n", sum(cactus_heights >= 5)))
  cat(sprintf("Number of sick cactus plants: %d\n", sum(cactus_heights < 5)))
  cat("\n")
  cat("Current state of player:\n")
  cat(sprintf("Player health: %d\n", player_health))
  cat(sprintf("Player hunger: %d\n", player_hunger))
  
  # Get user input
  user_input <- readline(prompt = "What would you like to do? (grow, search, eat, quit) ")
  
  # Execute user's choice
  if (user_input == "grow") {
    grow_cacti()
  }
  else if (user_input == "search") {
    search_for_water()
  }
  else if (user_input == "eat") {
    eat_cactus()
  }
  else if (user_input == "quit") {
    break
  }
  
  # Update player hunger and health
  player_hunger <<- player_hunger + 1
  player_health <<- player_health - sum(cactus_heights == 0)
  water_level <<- water_level - 1
  
  # Check if game is over
  if (check_game_over()) {
    break
  }
}
