#!/usr/bin/perl

use strict;
use warnings;

# Set up the game
my $food = 3;
my $water = 3;
my $shelter = 3;
my $health = 10;
my $turn = 1;

# Play the game
while ($health > 0) {
    # Display the game status
    print "\nTurn $turn\n";
    print "Food: $food\n";
    print "Water: $water\n";
    print "Shelter: $shelter\n";
    print "Health: $health\n";

    # Ask the player what to do
    print "\nWhat would you like to do?\n";
    print "1. Hunt for food\n";
    print "2. Look for water\n";
    print "3. Build shelter\n";
    print "4. Rest\n";
    print "5. Quit\n";
    print "> ";
    chomp(my $choice = <STDIN>);

    # Handle the player's choice
    if ($choice == 1) {
        # Hunt for food
        if (int(rand(2))) {
            print "You successfully hunted for food!\n";
            $food++;
        }
        else {
            print "You were unsuccessful in your hunt.\n";
            $food--;
        }
    }
    elsif ($choice == 2) {
        # Look for water
        if (int(rand(2))) {
            print "You found a source of water!\n";
            $water++;
        }
        else {
            print "You were unable to find any water.\n";
            $water--;
        }
    }
    elsif ($choice == 3) {
        # Build shelter
        if (int(rand(2))) {
            print "You successfully built a shelter!\n";
            $shelter++;
        }
        else {
            print "You were unable to build a shelter.\n";
            $shelter--;
        }
    }
    elsif ($choice == 4) {
        # Rest
        $health += 2;
        $food--;
        $water--;
        print "You rest and regain some health.\n";
    }
    elsif ($choice == 5) {
        # Quit
        print "Thanks for playing!\n";
        exit;
    }
    else {
        # Invalid choice
        print "Invalid choice. Please try again.\n";
    }

    # Update the game status
    $food--;
    $water--;
    $shelter--;
    $health--;
    $turn++;
}

# The player has lost
print "You have died. Game over.\n";
