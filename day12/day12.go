package day12

import (
	"container/heap"
	"fmt"
	"ghaith/aoc2022/utils"
	"math"

	// "golang.org/x/exp/slices"
)

type Coordinate struct {
	x int
	y int
}

type Node struct {
	name rune
	calculatedValue int
	position Coordinate 
}

type Edge struct {
	node *Node
	weight int //Always 1?
}

type Graph struct {
	Nodes []*Node
	Edges map[*Coordinate][]*Edge
}

func NewGraph() *Graph {
	return &Graph{
		Edges: make(map[*Coordinate][]*Edge),
	}
}

func (g *Graph) AddNode(n *Node) {
	g.Nodes = append(g.Nodes, n)
}

func (g *Graph) AddEdge(from, to *Node, weight int) {
	g.Edges[&from.position] = append(g.Edges[&from.position], &Edge{to, weight})
}

//Builds a graph with a start and end node
func buildGraph(input []string) (graph *Graph, start *Node, end *Node) {
	graph = NewGraph()
	allNodes := make([][]*Node, len(input))
	for lineNo,line := range input {
		allNodes[lineNo] = make([]*Node, len(line))
		for charNo, char := range line {
			position := Coordinate{lineNo, charNo}
			node := &Node {
				char,
				math.MaxInt,
				position,
			}
			allNodes[lineNo][charNo] = node
			graph.AddNode(node)
			if node.name == 'S' {
				start = node
				node.calculatedValue = 0
			} else if node.name == 'E' {
				end = node
			}
		}
	}

	for i, nodes := range allNodes {
		for j, node := range nodes {
			value := getNodeValue(node) 
			//get nodes around it
			if i > 0 {
				top := allNodes[i-1][j]
				if getNodeValue(top) - value < 2 {
					graph.AddEdge(node, top, 1)
				}
			}
			if i < len(allNodes) - 1 {
				bottom := allNodes[i+1][j]
				if getNodeValue(bottom) - value < 2 {
					graph.AddEdge(node, bottom, 1)
				}
			}
			if j > 0 {
				left := allNodes[i][j-1]
				if getNodeValue(left) - value < 2 {
					graph.AddEdge(node, left, 1)
				}
			}
			if j < len(nodes) - 1 {
				right := allNodes[i][j+1]
				if getNodeValue(right) - value < 2 {
					graph.AddEdge(node, right, 1)
				}
			}

		}
	}
	return
}

func getNodeValue(node *Node) int {
			str := node.name
			if str == 'S' {
				str = 'a'
			} else if str == 'E' {
				str = 'z'
			}
			return int(str)
}

type Heap []*Node
func (h Heap) Len() int           { return len(h) }
func (h Heap) Less(i, j int) bool { return h[i].calculatedValue < h[j].calculatedValue }
func (h Heap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *Heap) Push(x any) {
	// Push and Pop use pointer receivers because they modify the slice's length,
	// not just its contents.
	*h = append(*h, x.(*Node))
}

func (h *Heap) Pop() any {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func calculateShortestPath(graph *Graph, startNodes []*Node, endNode *Node) (path []*Node){
	for _, startNode := range startNodes {
		// if slices.Contains(path, startNode) {
		// 	fmt.Println("Path contains ", *startNode)
		// 	idx := slices.Index(path, startNode)
		// 	path = path[idx:]
		// 	continue
		// }

		visited := make(map[Coordinate]bool)
		dists := make(map[*Node]int)
		prev := make(map[*Node]*Node)
		dists[startNode] = 0
		startNode.calculatedValue = 0
		h := &Heap{startNode}
		heap.Init(h)

		for h.Len() > 0 {
			if visited[endNode.position] {
				break
			}

			item := heap.Pop(h).(*Node)
			for _,edge := range graph.Edges[&item.position] {
				dest := edge.node
				dist := dists[item] + edge.weight
				if tentativeDist, ok := dists[dest]; !ok || dist < tentativeDist {
					dists[dest] = dist
					dest.calculatedValue = dist
					prev[dest] = item
					heap.Push(h, edge.node)
				}
			}
			visited[item.position] = true

		}
		if !visited[endNode.position] {
			continue	
		}
		nextPath := []*Node{endNode}
		for next := prev[endNode]; next != nil; next = prev[next] {
			nextPath = append(nextPath, next)
		}

		if len(path) == 0 || len(nextPath) < len(path) {
			path = nextPath
		}

	}
	return path
}


func Day12() {
	input, err := utils.ReadInput("day12/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input))
	fmt.Println(part2(input))
}

func part1(input []string) int {
	g,start,end := buildGraph(input)
	path := calculateShortestPath(g, []*Node {start} , end)
	// for _, entry := range path {
	// 	fmt.Print(string(*&entry.name))
	// }
	// fmt.Println()
	return len(path) - 1 //Don't count start
}

func part2(input []string) int {
	g,start,end := buildGraph(input)
	startPathes := []*Node {start}
	for _, node := range g.Nodes {
		if node.name == 'a' {
			startPathes = append(startPathes, node)
		}
	}
	path := calculateShortestPath(g, startPathes , end)
	return len(path) - 1 //Don't count start
}
