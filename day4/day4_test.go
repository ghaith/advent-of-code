package day4

import (
	"ghaith/aoc2022/utils"
	"testing"
)

func TestDuplicateItemsInCompartment(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day4_sample.txt")
	if err != nil {
		t.Fatal(err)
	}

	res := part1(data)

	//Verify
	if res != 2 {
		t.Errorf("Expected 2 but was %d", res)
	}

}

func TestBadges(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day4_sample.txt")
	if err != nil {
		t.Fatal(err)
	}

	res := part2(data)

	//Verify
	if res != 4 {
		t.Errorf("Expected 4 but was %d", res)
	}


} 
