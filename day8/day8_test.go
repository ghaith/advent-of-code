package day8

import (
	"ghaith/aoc2022/utils"
	"testing"
)

func TestPart1(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day8_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	assert(t, 21, part1(data))

}

func TestPart1Input(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("input.txt")
	if err != nil {
		t.Fatal(err)
	}
	assert(t, 1690, part1(data))

}

func TestPart2(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day8_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	assert(t, 8, part2(data))

}

func assert(t *testing.T, left, right int) {
	if left != right {
		t.Errorf("Expected %d but was %d", left, right)
	}
}
