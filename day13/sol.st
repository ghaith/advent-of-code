TYPE Point : STRUCT x,y : DINT; END_STRUCT END_TYPE

VAR_GLOBAL
END_VAR
	
FUNCTION main : DINT
VAR_TEMP
	input : ARRAY[0..1000] OF Point;
	input_size : DINT := 0;
END_VAR


input_size := set_input(&input);

printf('Input %d$n', input_size);
//print(&input, input_size, 10,14);
// input_size := fold_y(&input, 7, input_size);
/* print(&input, input_size, 10,6); */
// printf('Sum : %d$n',input_size);
// input_size := fold_x(&input, 5, input_size);
/* print(&input, input_size, 4,6); */
/* print(&input, input_size, 1310,893); */
input_size := fold_x(&input, 655, input_size);
printf('Sum : %d$n',input_size);
input_size := fold_y(&input, 447, input_size);
input_size := fold_x(&input, 327, input_size);
input_size := fold_y(&input, 223, input_size);
input_size := fold_x(&input, 163, input_size);
input_size := fold_y(&input, 111, input_size);
input_size := fold_x(&input, 81, input_size);
input_size := fold_y(&input, 55, input_size);
input_size := fold_x(&input, 40, input_size);
input_size := fold_y(&input, 27, input_size);
input_size := fold_y(&input, 13, input_size);
input_size := fold_y(&input, 6, input_size);
print(&input, input_size, 40,6);
printf('Sum : %d$n',input_size);
printf('Done $n');

END_FUNCTION

FUNCTION print : __VOID
	VAR_INPUT
		input : REF_TO ARRAY[0..1000] OF Point;
		size:  DINT;
		x_max,y_max : DINT;
	END_VAR
	VAR_TEMP
		grid : ARRAY[0..1310,0..893] OF DINT;
		i,j : DINT;
		ele : Point;
	END_VAR

	FOR i := 0 TO x_max DO
		FOR j := 0 TO y_max DO
			grid[i,j] := FALSE;
		END_FOR
	END_FOR

	FOR i := 0 TO size - 1 DO 
		ele := input^[i];
		grid[ele.x,ele.y] := TRUE;
	END_FOR


	FOR j := 0 TO y_max DO
		FOR i := 0 TO x_max DO
			IF grid[i,j] THEN
				printf('#');
			ELSE
				printf('.');
			END_IF
		END_FOR
		printf('$n');
	END_FOR
	printf('=====================================$n');

END_FUNCTION

FUNCTION fold_y : DINT
	VAR_INPUT
		grid : REF_TO ARRAY[0..1000] OF Point;
		y : DINT;
		size : DINT;
	END_VAR
	VAR_TEMP
		i,j,count,trans : DINT := 0;
		new_grid: ARRAY[0..1000] OF Point;
		ele : Point;
	END_VAR
	count := 0;

	FOR i := 0 TO size DO
		new_grid[i].x := -1;
		new_grid[i].y := -1;
	END_FOR

	FOR i := 0 TO size DO
		IF grid^[i].y > y THEN 
			trans := y - ABS(y-grid^[i].y);
			new_grid[i].x := grid^[i].x;
			new_grid[i].y := trans;
		ELSIF grid^[i].y < y THEN
			new_grid[i] := grid^[i];
		END_IF
	END_FOR

	FOR i := 0 TO size DO
		grid^[i] := new_grid[i];
		new_grid[i].x := -1;
		new_grid[i].y := -1;
	END_FOR

	//Remove duplicate value from the array and count the unique elements
	FOR i := 0 TO size  DO //For every element in the grid
		ele := grid^[i];
		IF ele.x > -1 AND NOT contains(&new_grid, ele, size) THEN
			new_grid[count].x := ele.x;
			new_grid[count].y := ele.y;
			count := count + 1;
		END_IF
	END_FOR

	FOR i := 0 TO size DO
		grid^[i] := new_grid[i];
	END_FOR

	fold_y := count;

END_FUNCTION

FUNCTION contains : BOOL
	VAR_INPUT
		grid: REF_TO ARRAY[0..1000] OF Point;
		ele : Point;
		size : DINT := 0;
	END_VAR
	VAR_TEMP
		i: DINT;
	END_VAR
	FOR i := 0 TO size  DO
			IF grid^[i].x = ele.x AND grid^[i].y = ele.y THEN
				contains := TRUE;
				RETURN;
			END_IF
	END_FOR

	contains := FALSE;
END_FUNCTION

FUNCTION fold_x : DINT
	VAR_INPUT
		grid : REF_TO ARRAY[0..1000] OF Point;
		x : DINT;
		size : DINT;
	END_VAR
	VAR_TEMP
		i,j,count,trans : DINT := 0;
		new_grid: ARRAY[0..1000] OF Point;
		ele : Point;
	END_VAR
	count := 0;

	FOR i := 0 TO size DO
		new_grid[i].x := -1;
		new_grid[i].y := -1;
	END_FOR


	FOR i := 0 TO size -1 DO
		IF grid^[i].x > x THEN 
			trans := x - ABS(x-grid^[i].x);
			new_grid[i].y := grid^[i].y;
			new_grid[i].x := trans;
			//printf('Transformed %d :  %d,%d => %d,%d$n', i, grid^[i].x, grid^[i].y, new_grid[i].x, new_grid[i].y);

		ELSIF grid^[i].x < x THEN
			new_grid[i] := grid^[i];
		END_IF
	END_FOR

	FOR i := 0 TO size DO
		grid^[i] := new_grid[i];
		new_grid[i].x := -1;
		new_grid[i].y := -1;
	END_FOR

	//Remove duplicate value from the array and count the unique elements
	FOR i := 0 TO size  DO //For every element in the grid
		ele := grid^[i];
		IF ele.x > -1 AND NOT contains(&new_grid, ele, size) THEN
			new_grid[count].x := ele.x;
			new_grid[count].y := ele.y;
			count := count + 1;
		END_IF
	END_FOR

	FOR i := 0 TO size DO
		grid^[i] := new_grid[i];
	END_FOR

	fold_x := count;


END_FUNCTION

FUNCTION ABS : DINT
	VAR_INPUT 
		x : DINT;
	END_VAR
	IF x < 0 THEN
		ABS := -x;
	ELSE
		ABS := x;
	END_IF
END_FUNCTION


@EXTERNAL
FUNCTION printf : DINT
VAR_INPUT
str : STRING[1024];
params : ...;
END_VAR
END_FUNCTION
