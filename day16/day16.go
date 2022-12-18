package day16

import (
	"container/heap"
	"fmt"
	"ghaith/aoc2022/utils"
	"regexp"
	"strconv"
	"strings"
)

type Node struct {
	name string
	rate int
	edges []string
}

type Graph map [string]*Node

type NodeParing struct {
	from,to *Node
	cost int
}

func (node *Node) Weight() int {
	if node.rate > 0 {
		return 2 //Time to open valve
	}
	return 1
}

func Day16() {
	input, err := utils.ReadInput("day16/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input))
	fmt.Println(part2(input))

}

func CreateGraph(input []string) Graph {
	res := make(Graph)

	pattern := `Valve ([A-Z][A-Z]) has flow rate=(\d*); tunnels? leads? to valves? (.*)`
	r,_ := regexp.Compile(pattern)
	for _, line := range input {
		desc := r.FindStringSubmatch(line)
		valve := desc[1]
		rate,_ := strconv.Atoi(desc[2])
		connections := strings.Split(desc[3], ", ")
		res[valve] = &Node{
			valve,
			rate,
			connections,
		}
	}
	
	return res
}

type Heap []*NodeParing


func (h Heap) Len() int           { return len(h) }
func (h Heap) Less(i, j int) bool { return h[i].cost < h[j].cost }
func (h Heap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *Heap) Push(x any) {
	// Push and Pop use pointer receivers because they modify the slice's length,
	// not just its contents.
	*h = append(*h, x.(*NodeParing))
}

func (h *Heap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func (g *Graph) CalculateDistances() (costs map[string]map[string]int) {
	costs = make(map[string]map[string]int)
	h := &Heap {}
	heap.Init(h)
	for name,node := range *g {
		costs[name] = make(map[string]int)
			h.Push(&NodeParing {
				node,
				node,
				0,
			})
			costs[name][name] = 0
	}

	for h.Len()>0 {
		pair := h.Pop().(*NodeParing)
		for _,c := range pair.from.edges {
			weight := (*g)[c].Weight()
			if tentativeDist, ok := costs[pair.from.name][c]; !ok || weight < tentativeDist {
				costs[pair.from.name][c] = weight
				h.Push(&NodeParing {
					pair.from,
					(*g)[c],
					weight,
				})
			}
		}
	}
	return
}

//Returns the pressure after time when taking the best path
func (g *Graph) Walk(start *Node, time int) int {
	costs := g.CalculateDistances()

	remaining := make(map[string]bool)
	for name,_ := range *g {
		remaining[name] = true
	}

	


	return 0
}



func part1(input []string) int {
	g := CreateGraph(input)
	// for k,v := range costs {
	// 	for n,c := range v {
	// 		fmt.Print(k, "->", n,":",c, ", ")
	// 	}
	// 	fmt.Println()
	// }
	return g.Walk(g["AA"], 30)
}

func part2(input []string) int {
	return 0
}
