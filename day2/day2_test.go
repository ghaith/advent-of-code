package day2

import (
	"ghaith/aoc2022/utils"
	"testing"
)

func TestDay1Part1Input(t *testing.T) {

	//Import the sample data
	data, err := utils.ReadInput("day2_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	//Run the day1 part a
	res := part1(data)

	//Verify
	if res != 15 {
		t.Errorf("Expected 15 but was %d", res)
	}

}

func TestDay1Part2Input(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day2_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	//Run the day1 part a
	res := part2(data)

	//Verify
	if res != 12 {
		t.Errorf("Expected 12 but was %d", res)
	}

}

func TestTargetAction(t *testing.T) {
	assert(t, getAction(Rock,Win), Paper)
	assert(t, getAction(Rock,Draw), Rock)
	assert(t, getAction(Rock,Loss), Sissors)

	assert(t, getAction(Paper,Win), Sissors)
	assert(t, getAction(Paper,Draw), Paper)
	assert(t, getAction(Paper,Loss), Rock)

	assert(t, getAction(Sissors,Win), Rock)
	assert(t, getAction(Sissors,Draw), Sissors)
	assert(t, getAction(Sissors,Loss), Paper)
	
}

func assert(t *testing.T, left,right Action) {
	if left != right {
		t.Errorf("Expected %d but was %d", right,left)
	}

}
