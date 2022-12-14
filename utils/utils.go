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

func FindMax(slice []int) int{
	m := 99999
	for i, e := range slice {
			if i==0 || e > m {
					m = e
			}
	}
	return m
}

func Index(vs []int, t int) int {
		for i, v := range vs {
        if v == t {
            return i
        }
    }
    return -1
}

func Reverse[S ~[]E, E any](s S)  {
    for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
        s[i], s[j] = s[j], s[i]
    }
}

func Sign(value int) int {
	if value < 0 {
		return -1
	}
	return 1
}
