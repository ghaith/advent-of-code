package day10

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"strconv"
	"strings"
)

func Day10() {
	input, err := utils.ReadInput("day10/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input))

	for _,line := range part2(input) {
		fmt.Println(line)
	}
}

func part1(input []string) int {
	instructions := parse(input)
	x := 1
	var cycles []int //TODO: This should be simpler
	cycles = append(cycles, 1)
	for _, instruction := range instructions {
		value, cycle := instruction.evaluate()
		for i := 0; i < cycle; i++ {
			cycles = append(cycles, x)
		}
		x += value
	}
	result := 0
	for i := 20; i <= 220; i += 40 {
		result += i * cycles[i]
	}
	return result
}

func part2(input []string) []string {
	instructions := parse(input)
	x := 1
	var cycles []int //TODO: This should be simpler
	cycles = append(cycles, 1)
	for _, instruction := range instructions {
		value, cycle := instruction.evaluate()
		for i := 0; i < cycle; i++ {
			cycles = append(cycles, x)
		}
		x += value
	}
	result := make([]string, 6)
	currentLine := 0
	for i, value := range cycles[1:] {
		if i % 40 == 0 && i > 0{
			currentLine++
		}
		drawnPixel := i % 40
		spriteLocation := value % 40
		if drawnPixel == spriteLocation || drawnPixel == spriteLocation - 1 || drawnPixel == spriteLocation + 1 {
			result[currentLine] += fmt.Sprint("#")
		} else {
			result[currentLine] += fmt.Sprint(".")
		}
	}
	return result
}

type InstructionType int

const (
	noop InstructionType = 0
	addx InstructionType = 1
)

type Instruction struct {
	operation InstructionType
	value     int
}

func parse(input []string) []Instruction {
	var res []Instruction
	for _, line := range input {
		commands := strings.Fields(line)
		switch commands[0] {
		case "noop":
			res = append(res, Instruction{noop, 0})
		case "addx":
			{
				value, _ := strconv.Atoi(commands[1])
				res = append(res, Instruction{addx, value})
			}
		}
	}
	return res
}

// Returns the number to add and the cycle time that got consumed
func (instruction *Instruction) evaluate() (int, int) {
	switch instruction.operation {
	case noop:
		return 0, 1
	case addx:
		return instruction.value, 2
	default:
		return 0, 0
	}
}
