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
	return !(other.end < r.start || r.end < other.start)
}
func (r *Range) join(other *Range) (res *Range){
	res = &Range {
		r.start,
		r.end,
		r.exclusions,
	}

	if other == nil {
		return
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

func (sensor *Sensor)	getBeaconLocations(line,min,max int) *Range {
	exclusions :=  make(map[Coordinate]bool)
	distance := sensor.location.manhattan(sensor.beacon)
	distanceToY := int(math.Abs(float64(sensor.location.y - line)))
	if distanceToY > distance {
		return nil
	}
	startX := utils.Max(min, sensor.location.x - (distance - distanceToY))
	endX := utils.Min(max, sensor.location.x + (distance - distanceToY))
	// startX := sensor.location.x - (distance - distanceToY)
	// endX := sensor.location.x + (distance - distanceToY)
	if sensor.beacon.y == line {
		(exclusions)[sensor.beacon] =  true
	}
	if sensor.location.y == line {
		(exclusions)[sensor.location] =  true
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

func remove(s []*Range, index int) []*Range {
	if index >= len(s) {
		return s
	}
	ret := make([]*Range, 0)
	ret = append(ret, s[:index]...)
	return append(ret, s[index+1:]...)
}

func reduce(ranges *[]*Range)  bool {
	idx := 0
	for len(*ranges) > 1 {
		r := (*ranges)[idx]
		*ranges = remove(*ranges,idx)
		for j,r2 := range *ranges {
				if r.overlap(r2) {
					*ranges = remove(*ranges,j)
					*ranges = append(*ranges, r.join(r2))
					return true
				}
		}
		*ranges = append(*ranges, r)
		if len(*ranges) == 2 {
			return false
		}
	}
	return false
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
		ranges = []*Range{}
		for _, sensor := range sensors {
			r := sensor.getBeaconLocations(i, min, max)
			if r != nil {
				ranges = append(ranges,r)
			}
		}
		for reduce(&ranges) { }
		if len(ranges) > 1 {
			y = i
			break
		}
	}
	x := 0
	if len(ranges) > 1 {
		if ranges[0].end < ranges[1].start {
			x = ranges[0].end + 1
		} else {
			x = ranges[1].end + 1
		}
	}

	return x * 4000000 + y
}
