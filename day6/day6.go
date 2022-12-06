package day6

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"strings"
)

type Range struct {
	start,end int
}

func Day6() {
	input, err := utils.ReadInput("day6/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input[0]))
	fmt.Println(part2(input[0]))
}

func part1(input string) int {
	last := 0
	current := 4

	for (current < len(input)) {
		marker := input[last:current]

		stop := true
		for _,i := range marker {
			if strings.Count(marker, string(i)) > 1 {
				last++
				current++
				stop = false
				break
			}
		}
		if stop {
			break
		}

	}

	return current
}

func part2(input string) int {
	last := 0
	current := 14

	for (current < len(input)) {
		marker := input[last:current]

		stop := true
		for _,i := range marker {
			if strings.Count(marker, string(i)) > 1 {
				last++
				current++
				stop = false
				break
			}
		}
		if stop {
			break
		}

	}

	return current
}
