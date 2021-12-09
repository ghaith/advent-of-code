//defined elsewere rows,cols,input
FUNCTION main : DINT
VAR_TEMP
	i,j,current, count,sum : DINT := 0;
	result : ARRAY[0..rows-1,0..cols-1] OF BOOL;
	basins : list;
	basin : Point;
END_VAR

FOR i:= 0 TO rows - 1 DO
	FOR j := 0 TO cols -1 DO
		(*If value is a 9 just skip it there is nothing bigger*)
		current := input[i,j];
		IF current < 9 THEN
			result[i,j] := TRUE;
			(* check up (i -1) *)
			IF i - 1 >= 0 THEN
				IF current >= input[i-1,j] THEN
					result[i,j] := FALSE;
				END_IF
			END_IF
			(* check down (i + 1) *)
			IF i + 1 < rows THEN
				IF current >= input[i+1,j] THEN
					result[i,j] := FALSE;
				END_IF
			END_IF
			(* check up (j -1) *)
			IF j - 1 >= 0 THEN
				IF current >= input[i,j-1] THEN
					result[i,j] := FALSE;
				END_IF
			END_IF
			(* check down (j + 1) *)
			IF j + 1 < cols THEN
				IF current >= input[i,j+1] THEN
					result[i,j] := FALSE;
				END_IF
			END_IF
		ELSE
			result[i,j] := FALSE;
		END_IF
	END_FOR
END_FOR

FOR i:= 0 TO rows - 1 DO
	FOR j := 0 TO cols -1 DO
		IF result[i,j] THEN
			count := count + 1;
			sum := sum + input[i,j] + 1;
			basin.y := i;
			basin.x := j;
			basins.add(calc_basin_size(&input,basin));
		END_IF
	END_FOR
END_FOR

printf('Count %d, Sum %d $n', count, sum);
printf('Basins %d,%d,%d, * %d$n', basins.get(0), basins.get(1), basins.get(2), basins.get(0) * basins.get(1) * basins.get(2));


END_FUNCTION

FUNCTION calc_basin_size : DINT
VAR_INPUT
	grid : REF_TO ARRAY[0..rows-1, 0..cols-1] OF DINT;
	basin_start : Point;
END_VAR
VAR_TEMP
	candidates : Stack;
	current : Point;
	pt : Point;
	visited : ARRAY[0..rows-1, 0..cols-1] OF BOOL := [10000(FALSE)];
	size : DINT := 0;
END_VAR
	candidates.push(basin_start);
	

	WHILE NOT candidates.is_empty() DO
		size := size + 1;
		current := candidates.pop();
		visited[current.y,current.x] := TRUE;
		(* check up (i -1) *)
		IF (current.y - 1) >= 0 THEN
			pt.x := current.x;
			pt.y := current.y - 1;
			IF grid^[pt.y,pt.x] < 9 AND NOT visited[pt.y,pt.x] THEN 
				candidates.push(pt);
			END_IF
			visited[pt.y,pt.x] := TRUE;
		END_IF
		(* check down (i + 1) *)
		IF (current.y + 1) < rows THEN
			pt.x := current.x;
			pt.y := current.y + 1;
			IF grid^[pt.y,pt.x] < 9 AND NOT visited[pt.y,pt.x] THEN 
				candidates.push(pt);
			END_IF
			visited[pt.y,pt.x] := TRUE;
		END_IF
		(* check up (j -1) *)
		IF (current.x - 1) >= 0 THEN
			pt.x := current.x - 1;
			pt.y := current.y;
			IF grid^[pt.y,pt.x] < 9 AND NOT visited[pt.y,pt.x] THEN 
				candidates.push(pt);
			END_IF
			visited[pt.y,pt.x] := TRUE;
		END_IF
		(* check down (j + 1) *)
		IF (current.x + 1) < cols THEN
			pt.x := current.x + 1;
			pt.y := current.y;
			IF grid^[pt.y,pt.x] < 9 AND NOT visited[pt.y,pt.x] THEN 
				candidates.push(pt);
			END_IF
			visited[pt.y,pt.x] := TRUE;
		END_IF
	END_WHILE

	calc_basin_size := size;
	printf('%d$n', size);

END_FUNCTION

