# Set up initial forest parameters
num_trees <- 50
tree_heights <- sample(10:30, num_trees, replace = TRUE)
tree_health <- sample(1:5, num_trees, replace = TRUE)
player_hunger <- 0
player_health <- 5

# Define functions for game mechanics
grow_trees <- function() {
  tree_heights <<- tree_heights + rnorm(num_trees, mean = 0.5, sd = 0.2)
  tree_heights[tree_heights < 0] <<- 0 # make sure heights don't go below zero
}

forage_for_food <- function() {
  food_found <<- rbinom(1, 10, 0.5)
  player_hunger <<- max(0, player_hunger - food_found)
  cat(sprintf("You found %d pieces of food.\n", food_found))
}

deforest <- function() {
  num_trees_to_cut <<- sample(5:15, 1)
  trees_to_cut <<- sample(num_trees, num_trees_to_cut)
  tree_health[trees_to_cut] <<- tree_health[trees_to_cut] - 1
  tree_health[tree_health < 1] <<- 1 # make sure health doesn't go below 1
}

regenerate_forest <- function() {
  new_tree_heights <<- sample(10:30, num_trees_to_cut, replace = TRUE)
  new_tree_health <<- sample(1:5, num_trees_to_cut, replace = TRUE)
  tree_heights[trees_to_cut] <<- new_tree_heights
  tree_health[trees_to_cut] <<- new_tree_health
}

check_game_over <- function() {
  if (player_health <= 0 || player_hunger >= 10) {
    cat("Game over - you did not survive :(\n")
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

# Start the game loop
while (TRUE) {
  # Print current state of forest and player
  cat("Current state of forest:\n")
  cat(sprintf("Number of trees: %d\n", num_trees))
  cat(sprintf("Average tree height: %.1f\n", mean(tree_heights)))
  cat(sprintf("Number of healthy trees: %d\n", sum(tree_health >= 3)))
  cat(sprintf("Number of sick trees: %d\n", sum(tree_health < 3)))
  cat("\n")
  cat("Current state of player:\n")
  cat(sprintf("Player health: %d\n", player_health))
  cat(sprintf("Player hunger: %d\n", player_hunger))
  
  # Get user input
  user_input <- readline(prompt = "What would you like to do? (grow, forage, cut, quit) ")
  
  # Execute user's choice
  if (user_input == "grow") {
    grow_trees()
  }
  else if (user_input == "forage") {
    forage_for_food()
  }
  else if (user_input == "cut") {
    deforest()
    regenerate_forest()
  }
  else if (user_input == "quit") {
    break
  }
  
  # Update player hunger and health
  player_hunger <<- player_hunger + 1
  player_health <<- player_health - sum(tree_health == 1)
  
  # Check if game is over
  if (check_game_over()) {
    break
  }
}
