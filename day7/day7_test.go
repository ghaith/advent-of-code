package day7

import (
	"ghaith/aoc2022/utils"
	"testing"
)

func TestPart1(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day7_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	tree,_ := createFilesystem(data,1)
	calculateSize(tree)
	assert(t, 95437 ,part1(tree))

}

func TestPart2(t *testing.T) {
	//Import the sample data
	data, err := utils.ReadInput("day7_sample.txt")
	if err != nil {
		t.Fatal(err)
	}
	tree,_ := createFilesystem(data,1)
	size := calculateSize(tree)
	assert(t, 24933642,part2(tree, size))


} 

func assert(t *testing.T, left,right int) {
	if left != right {
		t.Errorf("Expected %d but was %d", left,right)
	}
}
