package day9

import (
	"ghaith/aoc2022/utils"
	"testing"
)

func TestPart1(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day9_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	assert(t, 13, part1(data))

}

func TestPart2(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day9_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	assert(t, 1, part2(data))
}

func TestPart3(t *testing.T) {
	data, err := utils.ReadInput("day9_sample2.txt")
	if err != nil {
		t.Fatal(err)
	}
	assert(t, 36, part2(data))

}

func assert(t *testing.T, left, right int) {
	if left != right {
		t.Errorf("Expected %d but was %d", left, right)
	}
}
