package day11

import (
	"ghaith/aoc2022/utils"
	"testing"
)

func TestPart1(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("test.txt")
	if err != nil {
		t.Fatal(err)
	}
	assert(t, 10605, part1(data))

}

func TestPart2(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("test.txt")
	if err != nil {
		t.Fatal(err)
	}

	assert(t, 2713310158, part2(data))

}

func assert(t *testing.T, left, right uint64) {
	if left != right {
		t.Errorf("Expected %d but was %d", left, right)
	}
}

func assertString(t *testing.T, left, right string) {
	if left != right {
		t.Errorf("Expected %s but was %s", right, left)
	}
}
