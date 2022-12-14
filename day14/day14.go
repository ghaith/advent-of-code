package day14

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"strconv"
	"strings"
)

func Day14() {
	input, err := utils.ReadInput("day14/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input))
	fmt.Println(part2(input))
}

type Cave struct {
	layout [][]Material
	startCoordinate Coordinate
	endCoordinate Coordinate

}
type Material int

type Coordinate struct {
	x,y int
}

const (
	Air Material = 0
	Rock Material = 1
	RestingSand Material = 2
	SandSource = 3
)

// const xOffset int = 494 //Move X back by 490 while drawing so we don't end up with empty useless elements

func (cave *Cave) AddRock(rock Coordinate) {
	if cave.layout[rock.y][rock.x] == Rock {
		return
	}

	cave.layout[rock.y][rock.x] = Rock
	if cave.startCoordinate.x > rock.x {
		cave.startCoordinate.x = rock.x
	}
	// if cave.startCoordinate.y > rock.y {
	// 	cave.startCoordinate.y = rock.y
	// }
	if cave.endCoordinate.x < rock.x {
		cave.endCoordinate.x = rock.x
	}
	if cave.endCoordinate.y < rock.y {
		cave.endCoordinate.y = rock.y
	}
}

func NewCave(dimensions Coordinate) Cave {
	caveLayout := [][]Material {}
	for i := 0; i < dimensions.y; i++ {
		airLine := []Material {}
		for i := 0; i < dimensions.x; i++ {
			airLine = append(airLine, Air)
		}
		caveLayout = append(caveLayout, airLine)
	}

	return Cave { caveLayout, Coordinate{dimensions.x, 0}, Coordinate{0, 0}}
	
}

func FillCave(input []string) (cave Cave) {
	cave = NewCave(Coordinate{1000, 1000})

	for _,line := range input {
		//Split on arrows
		rockCoordinates := strings.Split(line, " -> ")
		rocks := []Coordinate {}
		for _,rock := range rockCoordinates {
			rock := strings.Split(rock, ",")
			x,_ := strconv.Atoi(rock[0])
			// x -= xOffset
			y,_ := strconv.Atoi(rock[1])
			rocks = append(rocks, Coordinate{x,y})
		}

		prev := rocks[0]
		for _,rock := range rocks[1:] {
			if prev.x != rock.x {
				sign := utils.Sign(rock.x-prev.x)
				for i := prev.x;(sign > 0 && (i < rock.x)) || i > rock.x; i += sign {
					cave.AddRock(Coordinate{i, prev.y})
				}
			}
			if prev.y != rock.y {
				sign := utils.Sign(rock.y-prev.y)
				for i := prev.y;(sign > 0 && (i < rock.y)) || i > rock.y; i += sign {
					cave.AddRock(Coordinate{prev.x, i})
				}
			}
			cave.AddRock(prev)
			cave.AddRock(rock)
			prev = rock
		}
	}
	cave.layout[0][500] = SandSource

	return
}

func (cave *Cave) DropSand() Coordinate {
	//Produce unit of sand
	sand := Coordinate{ 500, 0}
	for sand.y < cave.endCoordinate.y {// && sand.x < cave.endCoordinate.x {
		if cave.layout[sand.y + 1][sand.x] == Air {
			sand.y++
			continue
		} else if cave.layout[sand.y+1][sand.x - 1] == Air {
			sand.y++
			sand.x--
		} else if cave.layout[sand.y+1][sand.x + 1] == Air {
			sand.y++
			sand.x++
		} else {
			cave.layout[sand.y][sand.x] = RestingSand
			break
		}
	}
	return sand
}

func (cave *Cave) ToString() (res string) {
	// fmt.Println("X : ", cave.startCoordinate.x, "->", cave.endCoordinate.x)
	for i := cave.startCoordinate.y; i <= cave.endCoordinate.y; i++ {
		res += fmt.Sprint(i)
		for j := cave.startCoordinate.x; j <= cave.endCoordinate.x; j++ {
				switch cave.layout[i][j] {
				case Air : res += fmt.Sprint(" . ")
				case Rock : res += fmt.Sprint(" # ")
				case RestingSand : res += fmt.Sprint(" o ")
				case SandSource : res += fmt.Sprint(" + ")
			}
		}
		res += fmt.Sprintln()
	}
	return
}

func part1(input []string) int {
	cave := FillCave(input)
	sand := cave.DropSand()
	idx := 0
	for sand.y < cave.endCoordinate.y {//&& sand.x < cave.endCoordinate.x {
		// fmt.Println(sand)
		sand = cave.DropSand()
		// fmt.Println(idx)
		// fmt.Println("------------------")
		// fmt.Println(cave.ToString())
		// fmt.Println("------------------")
		idx++
	}
	return idx
}

func part2(input []string) int {
	cave := FillCave(input)
	sand := cave.DropSand()
	endY := cave.endCoordinate.y + 2
	for i := 0; i < 1000; i++ {
		rock := Coordinate{ i, endY}
		// fmt.Println(rock)
		cave.AddRock(rock)
	}
	idx := 1
	// fmt.Println(cave.endCoordinate)
	for sand.y > 0 { //&& sand.x < cave.endCoordinate.x {
		// fmt.Println(sand)
		sand = cave.DropSand()
		// fmt.Println(idx)
		// fmt.Println("------------------")
		// fmt.Println(cave.ToString())
		// fmt.Println("------------------")
		idx++
	}
	return idx
}
