package day9

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"math"
	"strconv"
	"strings"
)

type Coordinates struct {
	x, y int
}

var grid map[Coordinates]int
var maxi, maxj, mini, minj int

func Day9() {
	input, err := utils.ReadInput("day9/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input))
	fmt.Println(part2(input))
}

func part1(input []string) int {
	maxi, maxj, mini, minj = 4, 5, 0, 0
	grid = make(map[Coordinates]int)
	start := Coordinates{x: 0, y: 0}
	//Visit start
	grid[start] = 1
	rope := []Coordinates{start, start}

	for _, command := range input {
		// fmt.Println("==",command,"==")
		// fmt.Println(rope)
		rope = makeMove(command, rope)
		// printGrid(rope)
		// fmt.Println()
	}

	// printResult(grid)
	return len(grid)
}

func part2(input []string) int {
	maxi, maxj, mini, minj = 15,15,-15, -15
	// maxi, maxj, mini, minj = 4, 5, 0, 0
	grid = make(map[Coordinates]int)
	start := Coordinates{x: 0, y: 0}
	//Visit start
	grid[start] = 1
	rope := []Coordinates{start, start, start, start, start, start, start, start, start, start}

	for _, command := range input {
		// fmt.Println("==",command,"==")
		// fmt.Println(rope)
		rope = makeMove(command, rope)
		// printGrid(rope)
		// fmt.Println()
	}

	// printResult(grid)
	return len(grid)
}

func makeMove(command string, rope []Coordinates) []Coordinates {
	actions := strings.Fields(command)
	direction := actions[0]
	value, _ := strconv.Atoi(actions[1])
	steps := value
	result := make([]Coordinates, len(rope))
	copy(result, rope)
	head := result[0]
	// fmt.Println("==", command, "==")
	for i := 0; i < steps; i++ {
		switch direction {
		case "R":
			head.x++
		case "L":
			head.x--
		case "U":
			head.y++
		case "D":
			head.y--
		}
		result[0] = head
		for i, tail := range result {
			if i > 0 {
				// fmt.Print("Index:", i, "Prev:", result[i-1], "Current", tail)
				result[i] = follow(tail, result[i-1])
				// fmt.Println(" Moved to:", result[i])
			}
		}
		// printGrid(result)
		// fmt.Println()
		grid[result[len(result)-1]]++
	}
	// printGrid(result)
	return result
}

func printResult(grid map[Coordinates]int) {
	for i := maxi; i >= mini; i-- {
		for j := minj; j < maxj; j++ {
			if i == 0 && j == 0 {
				fmt.Print("s")
			} else if grid[Coordinates{j, i}] > 0 {
				fmt.Print("#")
			} else {
				fmt.Print(".")
			}
		}
		fmt.Println()
	}
}

func printGrid(rope []Coordinates) {
	for i := maxi; i >= mini; i-- {
		for j := minj; j <= maxj; j++ {
			toPrint := "."
			if i == 0 && j == 0 {
				toPrint = "s"
			}
			for c, knot := range rope {
				if knot.x == j && knot.y == i {
					if c == 0 {
						toPrint = "H"
					} else {
						toPrint = fmt.Sprint(c)
					}
					break
				}
			}
			fmt.Print(toPrint)
		}
		fmt.Println()
	}
}

func isTouching(head, tail Coordinates) bool {
	return math.Abs(float64(head.x - tail.x)) <= 1 && math.Abs(float64(head.y - tail.y)) <= 1 

}

func follow(tail Coordinates, head Coordinates) Coordinates {
	result := tail
	if !isTouching(head,result) {

		dx := head.x - tail.x
		dy := head.y - tail.y

		moveX := 0
		moveY := 0
		if dx < 0 {
			moveX = -1
		} else if dx > 0 {
			moveX = 1
		}
		if dy < 0 {
			moveY = -1
		} else if dy > 0 {
			moveY = 1
		}

		result.x += moveX
		result.y += moveY

	}
	// fmt.Println(result)
	return result
}
