package day1

import (
	"ghaith/aoc2022/utils"
	"testing"
)

func TestDay1Part1Input(t *testing.T) {
	
	//Import the sample data
	data,err := utils.ReadInput("day1_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	//Run the day1 part a
	res := part1(data)
	
	//Verify
	if res != 24000 {
		t.Errorf("Expected 24000 but was %d", res)
	}

}

func TestDay1Part2Input(t *testing.T) {
	//Import the sample data
	data,err := utils.ReadInput("day1_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	//Run the day1 part a
	res := part2(data)

	//Verify
	if res != 45000 {
		t.Errorf("Expected 45000 but was %d", res)
	}
	

}

