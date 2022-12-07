package day7

import (
	"fmt"
	"ghaith/aoc2022/utils"
	"sort"
	"strconv"
	"strings"
)

type TreeNode struct {
	Name  string
	Data  int //0 is dir
	isDir bool
}

type Tree map[TreeNode]Tree

func Day7() {
	input, err := utils.ReadInput("day7/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}
	tree, _ := createFilesystem(input, 1)
	tree, size := calculateSize(tree)

	fmt.Println(part1(tree))
	fmt.Println(part2(tree, size))
}

func part1(input Tree) int {
	//printTree(input, "")
	res := Walk(input, func(node TreeNode) bool {
		return node.isDir && node.Data < 100000
	})

	return utils.Sum(res)

}

func part2(input Tree, size int) int {
	freeSpace := 70000000 - size
	required := 30000000 - freeSpace

	res := Walk(input, func(node TreeNode) bool {
		//Directories bigger than required space
		return node.isDir && node.Data >= required
	})
	sort.Ints(res)
	return res[0]
}

type filter = func(TreeNode) bool

func Walk(tree Tree, fn filter) []int {
	var res []int
	for node, next := range tree {
		if fn(node) {
			res = append(res, node.Data)
		}
		if node.isDir {
			res = append(res, Walk(next, fn)...)
		}
	}

	return res

}

func calculateSize(tree Tree) (Tree, int) {
	size := 0
	res := make(Tree)
	for node, next := range tree {
		if node.isDir && node.Data == 0 {
			next, node.Data = calculateSize(next)
		}
		res[node] = next
		size += node.Data
	}
	return res, size
}

func createFilesystem(input []string, index int) (Tree, int) {
	res := make(Tree)
	for index < len(input) {
		command := input[index]
		commandSections := strings.Fields(command)
		if commandSections[0] == "$" {
			//If the command is ls ignore it and proceed
			if commandSections[1] == "ls" {
			} else
			//If command is cd, we enter the new tree element to fill
			if commandSections[1] == "cd" {
				if commandSections[2] == ".." {
					return res, index
				}
				//add content
				node := TreeNode{
					commandSections[2],
					0,
					true,
				}
				res[node], index = createFilesystem(input, index+1)
			}
		} else {
			//This is a directory listing
			if commandSections[0] != "dir" {
				size, _ := strconv.Atoi(commandSections[0])
				name := commandSections[1]
				node := TreeNode{
					name,
					size,
					false,
				}
				res[node] = nil
			}
		}
		index++
	}

	return res, index

}

func printTree(tree Tree, separator string) {
	for node, next := range tree {
		fmt.Println(separator, node)
		printTree(next, separator+" ")
	}
}
