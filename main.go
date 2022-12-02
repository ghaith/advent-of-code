package main

import (
	"fmt"
	"ghaith/aoc2022/day1"
	"ghaith/aoc2022/day2"
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
	}
}
