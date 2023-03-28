package main

import (
	"fmt"
	"math/rand"
	"time"
)

const (
	HungerRate    = 10
	ThirstRate    = 8
	ExhaustionRate = 6
)

type Player struct {
	Name      string
	Hunger    int
	Thirst    int
	Exhausted bool
	Dead      bool
}

func (p *Player) Update() {
	p.Hunger += HungerRate
	p.Thirst += ThirstRate
	if p.Exhausted {
		p.Hunger += ExhaustionRate
		p.Thirst += ExhaustionRate
	}
	if p.Hunger >= 100 || p.Thirst >= 100 {
		p.Dead = true
	}
}

func main() {
	rand.Seed(time.Now().UnixNano())

	// Set up player
	player := &Player{
		Name:   "Survivor",
		Hunger: 0,
		Thirst: 0,
	}

	// Play game
	fmt.Println("Welcome to Survival Game!")
	for !player.Dead {
		// Update player stats
		player.Update()

		// Show status
		fmt.Printf("\n%s's status:\n", player.Name)
		fmt.Printf("Hunger: %d\n", player.Hunger)
		fmt.Printf("Thirst: %d\n", player.Thirst)
		if player.Exhausted {
			fmt.Println("Exhausted!")
		}

		// Get player action
		var action string
		for {
			fmt.Println("\nWhat do you want to do?")
			fmt.Println("(h)unt for food")
			fmt.Println("(g)ather water")
			fmt.Println("(r)est")
			fmt.Println("(q)uit")
			fmt.Print("> ")
			fmt.Scanln(&action)
			action = string(action[0])
			if action == "h" || action == "g" || action == "r" || action == "q" {
				break
			}
			fmt.Println("Invalid action, please try again.")
		}

		// Perform action
		switch action {
		case "h":
			fmt.Println("Hunting...")
			if rand.Intn(10) < 3 {
				fmt.Println("You caught a rabbit!")
				player.Hunger -= 50
			} else {
				fmt.Println("You failed to catch anything.")
			}
		case "g":
			fmt.Println("Gathering water...")
			if rand.Intn(10) < 5 {
				fmt.Println("You found a stream!")
				player.Thirst -= 40
			} else {
				fmt.Println("You couldn't find any water.")
			}
		case "r":
			fmt.Println("Resting...")
			player.Exhausted = false
			player.Hunger += 20
			player.Thirst += 15
		case "q":
			fmt.Println("Quitting...")
			return
		}

		// Check for exhaustion
		if player.Hunger >= 80 || player.Thirst >= 80 {
			player.Exhausted = true
			fmt.Println("You are exhausted and need to rest.")
		}
	}

	// Game over
	fmt.Println("Game over, you died!")
}
