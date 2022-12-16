package day15

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"math"
	"regexp"
	"strconv"
)

type ItemType string

type Coordinate struct {
	x,y int
}

type Range struct {
	start,end int
	exclusions map[Coordinate]bool
}

func (r *Range) overlap(other *Range) bool {
	
	return r.start <= other.start || r.end >= other.start ||
	other.start <= r.start || other.end >= r.start

}
func (r *Range) join(other *Range) (res *Range){
	res = &Range {
		r.start,
		r.end,
		r.exclusions,
	}

	if other.start < r.start {
		res.start = other.start
	}
	if other.end > r.end {
		res.end = other.end
	}

	for k,v := range other.exclusions {
		res.exclusions[k] = v
	}

	return
}

func (r *Range) length() int {
	return r.end - r.start - len(r.exclusions)
}


const (
	SensorType ItemType = "S"
	BeaconType ItemType = "B"
	Nothing ItemType = "#"
)

type Sensor struct {
	location Coordinate
	beacon Coordinate
}

func (item Coordinate) manhattan(other Coordinate) int {
	return int(math.Abs(float64(item.x - other.x)) + math.Abs(float64(item.y - other.y)))
}

type Grid map[Coordinate]ItemType

func ParseInput(input []string) []Sensor {
	pattern := `Sensor at x=(-?\w+), y=(-?\w+): closest beacon is at x=(-?\w+), y=(-?\w+)`
	matcher,_ := regexp.Compile(pattern)
	// res := make(Grid)
	res := make([]Sensor, 0)

	for _,line := range input {
		hits := matcher.FindStringSubmatch(line)
		sensorX,_ := strconv.Atoi(hits[1])
		sensorY,_ := strconv.Atoi(hits[2])
		beaconX,_ := strconv.Atoi(hits[3])
		beaconY,_ := strconv.Atoi(hits[4])

		sensorCoordinate := Coordinate{sensorX, sensorY};
		beaconCoordinate := Coordinate{beaconX, beaconY};
		res = append(res, Sensor{ sensorCoordinate, beaconCoordinate})
	}
	return res
}

func (grid *Grid) FillLocations(sensor Sensor, gridSize Coordinate, line int) {
	//Add the sensor and beacon to the grid
	distance := sensor.location.manhattan(sensor.beacon)

	minX := utils.Max(gridSize.x, sensor.location.x - distance)
	maxX := utils.Min(gridSize.y, sensor.location.x + distance)
	// minY := utils.Max(gridSize.x, sensor.location.y - distance)
	// maxY := utils.Min(gridSize.y, sensor.location.y + distance)

	// fmt.Println(minX, maxX, minY, maxY)

	for i := minX; i < maxX; i++ {
		// for j := minY; j < maxY; j++ {
			next := Coordinate{i, line}
			if sensor.location.manhattan(next) <= distance {
				(*grid)[next] = Nothing
			}
		// }
	}

	(*grid)[sensor.location] = SensorType
	(*grid)[sensor.beacon] = BeaconType

}

func (sensor *Sensor)	getBeaconLocations(line,min,max int) (res *Range) {
	exclusions :=  make(map[Coordinate]bool)
	distance := sensor.location.manhattan(sensor.beacon)
	distanceToY := int(math.Abs(float64(sensor.location.y - line)))
	startX := utils.Max(min, sensor.location.x - (distance - distanceToY))
	endX := utils.Min(max, sensor.location.x + (distance - distanceToY))
	if startX > endX {
		mid := startX
		startX = endX
		endX = mid
	}
	if sensor.beacon.y == line {
		(exclusions)[sensor.beacon] =  true
	}
	return &Range {
		startX,
		endX,
		exclusions,
	}
}

func Day15() {
	input, err := utils.ReadInput("day15/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input, 2000000))
	fmt.Println(part2(input, 0, 4000000))

}

func remove(s []int, i int) []int {
    s[i] = s[len(s)-1]
    return s[:len(s)-1]
}

func part1(input []string, line int) int {
	sensors := ParseInput(input)
	var lineRange *Range
	for _, sensor := range sensors {
		r := sensor.getBeaconLocations(line, math.MinInt, math.MaxInt)
		if lineRange == nil {
			lineRange = r
		} else {
			lineRange = lineRange.join(r)
		}
	}

	return lineRange.length() + 1
}

func part2(input []string, min, max int) int {
	sensors := ParseInput(input)
	ranges := make([]*Range,0)
	y := min
	for i := min; i < max; i++ {
		for _, sensor := range sensors {
			ranges = append(ranges,sensor.getBeaconLocations(i, min, max))
		}
		if i == 11 {
			for _, r := range ranges {
				fmt.Print(*r)
			}
			fmt.Println()
		}
		//reduce
		for len(ranges) > 1 {
			first := ranges[0]
			second := ranges[1]
			ranges = ranges[2:]
			if first.overlap(second) {
				newRange := first.join(second)
				ranges = append(ranges, newRange)
			} else {
				ranges = append(ranges, first,second)
				if len(ranges) == 2 {
					break
				}
			}
		}
		if len(ranges) > 1 {
			y = i
			break
		}
	}

	x := 0
	if len(ranges) > 1 {
		if ranges[0].start < ranges[1].start {
			x = ranges[0].end - ranges[1].start
		} else {
			x = ranges[1].end - ranges[0].start
		}
	}


	return x * 4000000 + y
}
