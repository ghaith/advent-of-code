package day15

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
	assert(t, 26, part1(data, 10))

}

func TestPart2(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("test.txt")
	if err != nil {
		t.Fatal(err)
	}

	assert(t, 56000011, part2(data, 0, 20))

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
