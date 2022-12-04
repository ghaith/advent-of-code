package day4

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"strconv"
	"strings"
)

type Range struct {
	start,end int
}

func Day4() {
	input, err := utils.ReadInput("day4/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input))
	fmt.Println(part2(input))
}

func part1(input []string) int {

	var res int
	for _, entry := range input {
		pairs := strings.Split(entry, ",");
		first := values(pairs[0])
		second := values(pairs[1])

		if contains(first,second) || contains(second,first) {
			res++
		}
	}
	return res
}

func part2(input []string) int {
	var res int
	for _, entry := range input {
		pairs := strings.Split(entry, ",");
		first := values(pairs[0])
		second := values(pairs[1])

		if overlap(first,second) || overlap(second,first) {
			// fmt.Println("Overlaping: ", first,second)
			res++
		}
	}
	return res
}

func values(input string) Range {
	entries := strings.Split(input, "-")
	start,_ := strconv.Atoi(entries[0])
	end,_ := strconv.Atoi(entries[1])
	return Range{
		start,
		end,
	}
}

func contains(first, second Range) bool {
	return first.start <= second.start && first.end >= second.end
}

func overlap(first, second Range) bool {
	return second.start <= first.end && second.end >= first.end
}

