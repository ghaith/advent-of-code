package day5

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"strconv"
	"strings"
)

type Range struct {
	start,end int
}

func Day5() {
	input, err := utils.ReadInput("day5/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	drawing,in := draw(input)
	// dst := make([][]string, len(drawing))
	// copy(dst, drawing)

	fmt.Println(part1(drawing, in))
	//Not sure why copying the array is not working
	drawing,in = draw(input)
	fmt.Println(part2(drawing, in))
}

func part1(drawing [][]string, input []string) string {
	var res string

	for _,s := range drawing {
		utils.Reverse(s)
	}

	for _, line := range input {
		move,from,to := readInst(line)

		for i := 0;i < move; i++ {
			//Pop value from res
			val := pop(&drawing[from - 1])
			//Push value to res
			push(&drawing[to - 1],val)
		}
	}

	for _,s := range drawing {
		res += pop(&s)
	}
	return res
}

func part2(drawing [][]string, input []string) string {
	var res string
	for _, line := range input {
		move,from,to := readInst(line)

		var intermediate []string
		take := drawing[from-1][:move]
		for _, s := range take {
			intermediate = append(intermediate,s)
		}
		if len(drawing[from-1]) > move {
			drawing[from-1] = drawing[from-1][move:]
		} else {
			drawing[from-1] = nil
		}

		drawing[to-1] = append(intermediate, drawing[to-1]...)

	}

	for _,s := range drawing {
		if len(s) > 0 {
			res += s[0]
		}
	}
	return res
}

func push(stack *[]string, val string) {
	*stack = append(*stack, val)
}

func pop(stack *[]string) string {
	if len(*stack) <= 0 {
		return ""
	} else {
		index := len(*stack) - 1 // Get the index of the top most element.
		element := (*stack)[index] // Index into the slice and obtain the element.
		*stack = (*stack)[:index] // Remove it from the stack by slicing it off.
		return element
	}
}

///Returns the drawing as a stack and the remainder
func draw(input []string) ([][]string, []string) {

	res := make([][]string,9)
	var break_index int
	for i, line := range input {
		if line == "" {
			break_index = i + 1
			break;
		}
		index := 0
		for len(strings.TrimSpace(line)) > 0 && !strings.ContainsRune(line, '1') {
			current := line[:3]
			if strings.TrimSpace(current) != "" {
				res[index] = append(res[index],current[1:2])
			}
			index++
			if len(line) >= 4 {
				line = line[4:]
			} else {
				break
			}
		}
	}
	return res,input[break_index:]

}

///Move X from X to X
func readInst(line string) (int,int,int) {
	instructions := strings.Fields(line)
	move,_ := strconv.Atoi(instructions[1])
	from,_ := strconv.Atoi(instructions[3])
	to,_ := strconv.Atoi(instructions[5])
	
	return move,from,to

}

