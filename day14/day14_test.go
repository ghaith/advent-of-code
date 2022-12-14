package day14

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
	assert(t, 24, part1(data))

}

func TestPart2(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("test.txt")
	if err != nil {
		t.Fatal(err)
	}

	assert(t, 93, part2(data))

}

func assert(t *testing.T, left, right int) {
	if left != right {
		t.Errorf("Expected %d but was %d", left, right)
	}
}

func assertString(t *testing.T, left, right string) {
	if left != right {
		t.Errorf("Expected %s but was %s", right, left)
	}
}
