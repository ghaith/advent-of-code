package day3

import (
	"bytes"
	"fmt"
	"ghaith/aoc2022/utils"
	"strings"
)

func Day3() {
	input, err := utils.ReadInput("day3/input.txt")

	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println(part1(input))
	fmt.Println(part2(input))
}

func part1(input []string) int {
	var sum int
	for _,rucksack := range input {
		len := len(rucksack)
		compA := rucksack[:len/2]
		compB := rucksack[len/2:]

		for _,char := range compA {
			if strings.ContainsRune(compB, char) {
				sum += bytes.IndexRune(lookup, char) + 1
				break
			}
		}

	}
	return sum
}

func part2(input []string) int {
	var sum int
	for len(input) > 0 {
		group := input[:3]
		input = input[3:]

		for _,char := range group[0] {
			if strings.ContainsRune(group[1], char) {
				if strings.ContainsRune(group[2], char) {
					sum += bytes.IndexRune(lookup, char) + 1
					break
				}
			}
		}


	}

	return sum
}

var lookup = []byte { 
	'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
	'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
}

