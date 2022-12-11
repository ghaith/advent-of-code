package day11

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"regexp"
	"sort"
	"strconv"
)

func Day11() {
	input, err := utils.ReadInput("day11/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input))
	fmt.Println(part2(input))
}

type Monkey struct {
	items     []uint64
	operation func(uint64) uint64
	divider      int 
	throwTrue int
	throwFalse int
}

func part1(input []string) uint64 {
	monkeys := parse(input)
	result := make([]uint64, len(monkeys))
	for i := 0; i < 20; i++ {
		for i, value := range runRound(&monkeys, 3) {
			result[i] += value
		}
		// for j, monkey := range monkeys {
		// 	fmt.Println(j, monkey.items)
		// }
	}
	// sort.Sort(sort.Reverse(sort.IntSlice(result)))
	sort.Slice(result, func(i,j int) bool { return result[i] > result[j] })
	return result[0] * result[1]
}

func part2(input []string) uint64 {
	monkeys := parse(input)
	result := make([]uint64, len(monkeys))
	for i := 0; i < 10000; i++ {
		for j, value := range runRound(&monkeys, 1) {
			result[j] += value
		}
		// for j, monkey := range monkeys {
		// 	fmt.Println(j, monkey.items)
		// }
		// fmt.Println("Round", i+1, ":", result)
	}
	// sort.Sort(sort.Reverse(sort.IntSlice(result)))
	sort.Slice(result, func(i,j int) bool { return result[i] > result[j] })
	// fmt.Println(result)
	return result[0] * result[1]
}

func runRound(monkeys *[]Monkey, worryModifier int) []uint64{
	biggestDivider := 1
	for _, monkey := range *monkeys {
			biggestDivider *= monkey.divider
	}
	result := make([]uint64, len(*monkeys))
	for i:=0;i<len(*monkeys);i++ {
		monkey := &(*monkeys)[i]
		for len(monkey.items) > 0 {
			item := monkey.items[0]
			monkey.items = monkey.items[1:]
			item = monkey.operation(item) % uint64(biggestDivider) / uint64(worryModifier)
			result[i]++
			nextM := 0
			if item % uint64(monkey.divider) == 0 {
				nextM = monkey.throwTrue
			} else {
				nextM = monkey.throwFalse
			}
			next := &(*monkeys)[nextM]
			next.items = append(next.items, item)
		}
	}
	return result
}

const itemsPattern string = `\d+`
const operationPattern string = `Operation: new = (\w+) ([\*\+]) (\w+)`
const testPattern string = `Test: divisible by (\d+)`
const truePattern string = `If true: throw to monkey (\d+)`
const falsePattern string = `If false: throw to monkey (\d+)`

func parse(input []string) []Monkey {
	var monkeys []Monkey
	itemsPattern := regexp.MustCompile(itemsPattern)
	operationPattern := regexp.MustCompile(operationPattern)
	testPattern := regexp.MustCompile(testPattern)
	truePattern := regexp.MustCompile(truePattern)
	falsePattern := regexp.MustCompile(falsePattern)

	for i := 0; i < len(input); i++ {
		//Read a monkey line
		i++
		line := input[i]
		//Read the items list
		var items []uint64
		for _, item := range itemsPattern.FindAllString(line,-1){
			item, _ := strconv.Atoi(item)
			items = append(items, uint64(item))
		}
		i++
		line = input[i]

		operationActions := operationPattern.FindStringSubmatch(line)[1:]
		operation := func(old uint64) uint64 {
			left := uint64(0)
			if operationActions[0] == "old" {
				left = old
			} else {
				val, _ := strconv.Atoi(operationActions[0])
				left = uint64(val)
			}
			right := uint64(0)
			if operationActions[2] == "old" {
				right = old
			} else {
				val, _ := strconv.Atoi(operationActions[2])
				right = uint64(val)
			}
			if operationActions[1] == "+" {
				return left + right
			} else {
				return left * right
			}
		}
		i++
		line = input[i]

		testValue, _ := strconv.Atoi(testPattern.FindStringSubmatch(line)[1])
		i++
		line = input[i]
		onTrue, _ := strconv.Atoi(truePattern.FindStringSubmatch(line)[1])
		i++
		line = input[i]
		onFalse, _ := strconv.Atoi(falsePattern.FindStringSubmatch(line)[1])
		i++

		monkey := Monkey{items, operation, testValue, onTrue, onFalse}
		monkeys = append(monkeys, monkey)

	}

	return monkeys
}
