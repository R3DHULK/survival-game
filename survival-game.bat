@echo off
title Survival Game

setlocal enabledelayedexpansion

:: Initialize variables
set "hunger=100"
set "thirst=100"
set "health=100"
set "distance_traveled=0"
set "days_survived=0"
set "game_over=false"

:: Game loop
:game_loop
cls
echo Survival Game
echo.
echo Status:
echo Hunger: %hunger%
echo Thirst: %thirst%
echo Health: %health%
echo Distance Traveled: %distance_traveled% miles
echo Days Survived: %days_survived%
echo.

:: Get user input
set /p "action=What do you want to do? (hunt, gather, rest, drink, walk): "

:: Validate input and execute action
if /i "%action%" equ "hunt" (
  set /a "hunger-=20"
  set /a "thirst-=10"
  set /a "health-=10"
  set /a "distance_traveled+=5"
  echo You spent the day hunting. You found some food and water and traveled 5 miles.
) else if /i "%action%" equ "gather" (
  set /a "hunger-=10"
  set /a "thirst-=20"
  set /a "health-=10"
  set /a "distance_traveled+=3"
  echo You spent the day gathering resources. You found some food and water and traveled 3 miles.
) else if /i "%action%" equ "rest" (
  set /a "hunger-=10"
  set /a "thirst-=10"
  set /a "health+=20"
  set /a "distance_traveled+=1"
  echo You spent the day resting. Your health improved and you traveled 1 mile.
) else if /i "%action%" equ "drink" (
  set /a "thirst+=30"
  echo You drank some water.
) else if /i "%action%" equ "walk" (
  set /a "hunger-=10"
  set /a "thirst-=10"
  set /a "health-=10"
  set /a "distance_traveled+=10"
  echo You spent the day walking. You traveled 10 miles.
) else (
  echo Invalid action. Please try again.
  pause >nul
)

:: Check status
if %hunger% leq 0 (
  echo You died of hunger.
  set "game_over=true"
) else if %thirst% leq 0 (
  echo You died of thirst.
  set "game_over=true"
) else if %health% leq 0 (
  echo You died of illness.
  set "game_over=true"
)

:: Check game over
if %game_over% equ true (
  echo Game over. You survived %days_survived% days and traveled %distance_traveled% miles.
  pause >nul
  exit
)

:: Increment days survived and loop
set /a "days_survived+=1"
goto game_loop
