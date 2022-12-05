package day5

import (
	"ghaith/aoc2022/utils"
	"testing"
)

func TestPart1(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day5_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	draw,data := draw(data)

	res := part1(draw, data)

	//Verify
	if res != "CMZ" {
		t.Errorf("Expected CMZ but was %s", res)
	}

}

func TestPart2(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day5_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	draw,data := draw(data)

	res := part2(draw,data)

	//Verify
	if res != "MCD" {
		t.Errorf("Expected MCD but was %s", res)
	}


} 
