package main

import (
	"fmt"
	"ghaith/aoc2022/day1"
	"ghaith/aoc2022/day2"
	"ghaith/aoc2022/day3"
	"ghaith/aoc2022/day4"
	"ghaith/aoc2022/day5"
	"ghaith/aoc2022/day6"
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
	}
}
