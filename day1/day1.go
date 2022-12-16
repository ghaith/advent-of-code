package day1

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"sort"
	"strconv"
)

func Day1() {
	input, err := utils.ReadInput("day1/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input))
	fmt.Println(part2(input))

}

func part1(input []string) int {
	max := -1

	var current int = 0

	for _, value := range input {
		//If this is an empty line, update max, set current to 0
		if value == "" {
			max = utils.Max(max, current)
			current = 0
			continue
		}

		next, err := strconv.Atoi(value)
		if err != nil {
			return -1
		}
		current += next
	}
	max = utils.Max(max, current)

	return max
}

func part2(input []string) int {
	var res []int

	var current int = 0

	for _, value := range input {
		//If this is an empty line, update max, set current to 0
		if value == "" {
			res = append(res, current)
			current = 0
			continue
		}

		next, err := strconv.Atoi(value)
		if err != nil {
			return -1
		}
		current += next
	}
	res = append(res, current)

	sort.Ints(res)

	return utils.Sum(res[len(res)-3:])

}
