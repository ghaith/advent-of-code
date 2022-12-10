package day10

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
	assert(t, 13140, part1(data))

}

func TestPart2(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("test.txt")
	if err != nil {
		t.Fatal(err)
	}
	res := part2(data)

	assertString(t, res[0] , "##..##..##..##..##..##..##..##..##..##..")
	assertString(t, res[1] , "###...###...###...###...###...###...###.")
	assertString(t, res[2] , "####....####....####....####....####....")
	assertString(t, res[3] , "#####.....#####.....#####.....#####.....")
	assertString(t, res[4] , "######......######......######......####")
	assertString(t, res[5] , "#######.......#######.......#######.....")
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
