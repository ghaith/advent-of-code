package day13

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"sort"
	"strconv"

	"golang.org/x/exp/slices"
)

type Pair struct {
	left  *Node
	right *Node
}

type NodeNature int

const (
	Val  NodeNature = 0
	List NodeNature = 1
)

type Node struct {
	nature NodeNature
	value  int
	node   []*Node
}

func (e *Node) IsVal() bool {
	return e.nature == Val
}

func (e *Node) IsList() bool {
	return e.nature == List
}

func (e *Node) getList() []*Node {
	if e.IsList() {
		return e.node
	}
	return []*Node{e}
}

func (e *Node) getVal() int {
	return e.value
}

func CreateIntNode(num int) *Node {
	return &Node{
		Val,
		num,
		nil,
	}
}

func CreateListNode(list []*Node) *Node {
	return &Node{
		List,
		0,
		list,
	}
}

func ParseInput(input []string) (res []Pair) {
	for i := 0; i < len(input)-1; i++ {
		left := ParseNode(input[i])
		i++
		right := ParseNode(input[i])
		i++

		// fmt.Println(left.toString())
		// fmt.Println(right.toString())
		// fmt.Println()
		res = append(res, Pair{left, right})
	}
	return
}

func ParseNode(line string) (node *Node) {
	if len(line) == 0 {
		return nil
	}

	if line[0] == '[' {
		sections := []string{}
		section := ""
		open := 0
		for _, c := range line[1 : len(line)-1] {
			switch c {
			case '[':
				{
					// if open == 0 {
					// 	sections = append(sections, section)
					// 	section = ""
					// }
					open++
					section += "["
				}
			case ']':
				{
					open--
					section += "]"
				}
			case ',':
				{
					if open == 0 {
						sections = append(sections, section)
						section = ""
					} else {
						section += ","
					}
				}
			default:
				section += string(c)

			}
		}
		if len(section) > 0 {
			sections = append(sections, section)
		}

		var list []*Node
		for _, section := range sections {
			if len(section) > 0 {
				list = append(list, ParseNode(section))
			}
		}
		node = CreateListNode(list)
	} else {
		value, _ := strconv.Atoi(line)
		node = CreateIntNode(value)
	}
	return
}

func (left *Node) Compare(right *Node) int {
	// fmt.Println("Comparing", left.toString(), "and", right.toString())
	if left.IsVal() && right.IsVal() {
		return left.getVal() - right.getVal()
	}
	l := left.getList()
	r := right.getList()
	res := 0
	for i, lVal := range l {
		if i >= len(r) {
			return 1
		}
		res = lVal.Compare(r[i])
		if res != 0 {
			return res
		}
	}
	if len(r) > len(l) {
		return -1
	}
	return 0
}

func (e *Node) toString() string {
	res := ""
	if e.IsVal() {
		res = fmt.Sprint(e.getVal())
	} else {
		res += "{"
		for _, node := range e.getList() {
			res += node.toString()
			res += ","
		}
		res += "}"
	}
	return res
}

func (pair Pair) InOrder() bool {
	return pair.left.Compare(pair.right) < 0
}

func Day13() {
	input, err := utils.ReadInput("day13/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input))
	fmt.Println(part2(input))
}

func part1(input []string) int {
	pairs := ParseInput(input)
	result := 0

	for idx, pair := range pairs {
		if pair.InOrder() {
			result += (idx + 1)
			// fmt.Println(idx + 1,result)
		}
	}
	return result
}

func part2(input []string) int {
	pairs := ParseInput(input)
	node2 := CreateListNode([]*Node{CreateIntNode(2)})
	node6 := CreateListNode([]*Node{CreateIntNode(6)})
	sections := []*Node {node2, node6}
	for _, pair := range pairs {
		sections = append(sections, pair.left, pair.right)
	}

	sort.Slice(sections, func(i, j int) bool {
		return sections[i].Compare(sections[j]) <= 0
	})

	idx2 := slices.Index(sections, node2) + 1
	idx6 := slices.Index(sections, node6) + 1
	// for _,s := range sections {
	// 	fmt.Println(s.toString())
	// }
	// fmt.Println(idx2, idx6)



	return idx2 * idx6
}
