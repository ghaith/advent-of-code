package day6

import (
	"ghaith/aoc2022/utils"
	"testing"
)

func TestPart1(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day6_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	assert(t, 7,part1(data[0]))
	assert(t, 5,part1(data[1]))
	assert(t, 6,part1(data[2]))
	assert(t, 10,part1(data[3]))
	assert(t, 11,part1(data[4]))

}

func TestPart2(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day6_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	assert(t, 19,part2(data[0]))
	assert(t, 23,part2(data[1]))
	assert(t, 23,part2(data[2]))
	assert(t, 29,part2(data[3]))
	assert(t, 26,part2(data[4]))


} 

func assert(t *testing.T, left,right int) {
	if left != right {
		t.Errorf("Expected %d but was %d", left,right)
	}
}
