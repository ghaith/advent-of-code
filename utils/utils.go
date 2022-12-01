package utils

import (
	"bufio"
	"os"
)
func ReadInput(filname string) ([]string, error) {
	readFile,err := os.Open(filname)

	if err != nil {
		return nil, err
	}

	fileScanner := bufio.NewScanner(readFile)
	fileScanner.Split(bufio.ScanLines)
	var result []string

	for fileScanner.Scan() {
		result = append(result, fileScanner.Text())
	}

	readFile.Close()

	return result,nil

}

func Max(a,b int) int {
	if a < b {
		return b
	}
	return a
}
  
func Sum(array []int) int {  
 result := 0  
 for _, v := range array {  
  result += v  
 }  
 return result  
}  
