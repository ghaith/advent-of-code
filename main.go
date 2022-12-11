package main

import (
	"fmt"
	"ghaith/aoc2022/day1"
	"ghaith/aoc2022/day10"
	"ghaith/aoc2022/day11"
	"ghaith/aoc2022/day2"
	"ghaith/aoc2022/day3"
	"ghaith/aoc2022/day4"
	"ghaith/aoc2022/day5"
	"ghaith/aoc2022/day6"
	"ghaith/aoc2022/day7"
	"ghaith/aoc2022/day8"
	"ghaith/aoc2022/day9"
	"os"
	"strconv"
)

func main() {
	arg := os.Args[1]
	day, err := strconv.Atoi(arg)
	if err != nil {
		fmt.Println("Expected a number as argument got", arg)
		return
	}

	switch day {
	case 1:
		day1.Day1()
	case 2:
		day2.Day2()
	case 3:
		day3.Day3()
	case 4:
		day4.Day4()
	case 5:
		day5.Day5()
	case 6:
		day6.Day6()
	case 7:
		day7.Day7()
	case 8:
		day8.Day8()
	case 9:
		day9.Day9()
	case 10:
		day10.Day10()
	case 11:
		day11.Day11()
	}
}
