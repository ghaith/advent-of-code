package day8

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"strconv"

	"golang.org/x/exp/slices"
)

type Coordinates struct {
	x, y int
}

func Day8() {
	input, err := utils.ReadInput("day8/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input))
	fmt.Println(part2(input))
}

func part1(input []string) int {
	treeMap := generateMap(input)
	// visible := 2 * len(treeMap) - 2 + 2 * len(treeMap[0]) - 2
	var visible []Coordinates

	for i, row := range treeMap {
		for j, value := range row {
			coordinate := Coordinates{
				i,
				j,
			}
			leftView := row[:j]
			rightView := row[j+1:]
			if !slices.Contains(visible, coordinate) {
				//See if the value is max in the row from the left
				if isEdge(treeMap, coordinate) || value > utils.FindMax(leftView) || value > utils.FindMax(rightView) {
					visible = append(visible, coordinate)
				}
			}
		}
	}

	transposed := transpose(treeMap)
	for i, row := range transposed {
		for j, value := range row {
			coordinate := Coordinates{
				j,
				i,
			}
			topView := row[:j]
			bottomView := row[j+1:]
			if !slices.Contains(visible, coordinate) {
				//See if the value is max in the row from the left
				if value > utils.FindMax(topView) || value > utils.FindMax(bottomView) {
					visible = append(visible, coordinate)
				}
			}
		}
	}

	return len(visible)
}

func part2(input []string) int {
	views := make(map[Coordinates]int)
	treeMap := generateMap(input)
	transposed := transpose(treeMap)

	for i, row := range treeMap {
		for j, value := range row {
			coordinate := Coordinates{
				i,
				j,
			}
			if isEdge(treeMap, coordinate) {
				views[coordinate] = 0
			} else {
				leftView := make([]int, len(row[:j]))
				copy(leftView, row[:j])
				utils.Reverse(leftView)
				rightView := row[j+1:]

				// if coordinate.x == 3 && coordinate.y == 2 {
				// 	fmt.Println(row, leftView, rightView)
				// }

				count := findVisibleTrees(leftView, value)
				views[coordinate] = count 

				count = findVisibleTrees(rightView, value)
				views[coordinate] = count * views[coordinate]
			}
		}
	}
	for i, row := range transposed {
		for j, value := range row {
			coordinate := Coordinates{
				j,
				i,
			}
			if isEdge(transposed, coordinate) {
				views[coordinate] = 0
			} else {
				leftView := make([]int, len(row[:j]))
				copy(leftView, row[:j])
				utils.Reverse(leftView)
				rightView := row[j+1:]

				count := findVisibleTrees(leftView, value)
				views[coordinate] = count * views[coordinate]

				count = findVisibleTrees(rightView, value)
				views[coordinate] = count * views[coordinate]

			}
		}
	}


	max := 0
	for _, value := range views {
		if value > max {
			max = value
		}
	}
	return max
}

func findVisibleTrees(view []int, value int) int {
	count := 0
	currentMax := 0
				for _, tree := range view {
					//If the tree is as big as me i can see it but no further
					if tree >= value {
						count++
						break
					} else {
						//If a tree is taller than what i've seen before, i can see it
						count++
						currentMax = utils.Max(currentMax,tree)
						if currentMax >= value {
							break
						}
					}
				}
				return count
}

func generateMap(input []string) [][]int {
	res := make([][]int, len(input))
	for i, line := range input {
		res[i] = make([]int, len(line))
		for j, r := range line {
			res[i][j], _ = strconv.Atoi(string(r))
		}
	}
	return res
}

func transpose(slice [][]int) [][]int {
	xl := len(slice[0])
	yl := len(slice)

	result := make([][]int, xl)

	for i := range result {
		result[i] = make([]int, yl)
	}

	for i := 0; i < xl; i++ {
		for j := 0; j < yl; j++ {
			result[i][j] = slice[j][i]
		}
	}
	return result
}

func isEdge(data [][]int, candidate Coordinates) bool {
	return candidate.x == 0 || candidate.x == len(data)-1 || candidate.y == 0 || candidate.y == len(data[0])-1
}
