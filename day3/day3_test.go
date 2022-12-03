package day3

import (
	"ghaith/aoc2022/utils"
	"testing"
)

func TestDuplicateItemsInCompartment(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day3_sample.txt")
	if err != nil {
		t.Fatal(err)
	}

	res := part1(data)

	//Verify
	if res != 157 {
		t.Errorf("Expected 157 but was %d", res)
	}

}

func TestBadges(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day3_sample.txt")
	if err != nil {
		t.Fatal(err)
	}

	res := part2(data)

	//Verify
	if res != 70 {
		t.Errorf("Expected 70 but was %d", res)
	}


} 
