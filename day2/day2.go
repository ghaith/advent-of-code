package day2

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"strings"
)

func Day2() {

	input, err := utils.ReadInput("day2/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Println(part1(input))
	fmt.Println(part2(input))
}

//Scores : X = 1, Y = 2, Z = 3
//Rock : A, X
//Paper: B, Y
//Sissors: C, Z

type Action int
type Target int

const (
	Rock Action = iota
	Paper
	Sissors
)

const (
	Loss Target = 0
	Draw        = 3
	Win         = 6
)

func score(this, other Action) int {
	score := int(this) + 1
	if this == other {
		score += 3
	} else if (this == Rock && other == Sissors) || (this == Sissors && other == Paper) || (this == Paper && other == Rock) {
		score += 6
	}
	return score
}

func getAction(action Action, target Target) Action {
	var res Action
	switch target {
	case Loss:
		res = (action + 2) % 3
	case Win:
		res = (action + 1) % 3
	default:
		res = action
	}
	return res
}

func value(char string) Action {
	switch char {
	case "A", "X":
		return Rock
	case "B", "Y":
		return Paper
	case "C", "Z":
		return Sissors
	}
	panic(char)
}

func target(char string) Target {
	switch char {
	case "X":
		return Loss
	case "Y":
		return Draw
	case "Z":
		return Win
	}
	panic(char)
}

func part1(input []string) int {
	var res []int

	for _, game := range input {
		entry := strings.Fields(game)
		opponent := value(entry[0])
		me := value(entry[1])

		score := score(me, opponent)
		// fmt.Println(entry, score)
		res = append(res, score)

	}

	return utils.Sum(res)
}

func part2(input []string) int {
	var res []int

	for _, game := range input {
		entry := strings.Fields(game)
		opponent := value(entry[0])
		target := target(entry[1])
		me := getAction(opponent, target)

		// fmt.Println("Actions ", opponent, "->", me)

		score := score(Action(me), opponent)
		// fmt.Println(entry, score)
		res = append(res, score)

	}

	return utils.Sum(res)

}
