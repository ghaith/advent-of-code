VAR_GLOBAL CONSTANT
	rows : DINT := 5;
	cols : DINT := 10;
END_VAR

VAR_GLOBAL
	input : ARRAY[0..rows-1,0..cols -1] OF DINT := 
[
2,1,9,9,9,4,3,2,1,0,
3,9,8,7,8,9,4,9,2,1,
9,8,5,6,7,8,9,8,9,2,
8,7,6,7,8,9,6,7,8,9,
9,8,9,9,9,6,5,6,7,8
];
END_VAR

