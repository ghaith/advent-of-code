VAR_GLOBAL CONSTANT
	grid : DINT := 10;
	steps : DINT := 100;
END_VAR

FUNCTION main : DINT
VAR_TEMP
	score : DINT := 0;
	i : DINT := 0;
END_VAR
	/* FOR i := 1 TO steps DO */
	/* 	/1* printf('============Step %d=============$n',i); *1/ */
	/* 	score := score + step(); */
	/* 	printf('Step %d Score %d$n', i, score); */
	/* END_FOR */

	WHILE score <> grid * grid AND i < 10000 DO
		score := step();
		i := i + 1;
	END_WHILE

printf('Score %d at %d$n', score, i);
END_FUNCTION

FUNCTION step : DINT
	VAR_TEMP
			in : ARRAY[0..grid-1, 0..grid-1] OF DINT;
			to_flash : Stack;
			current,next : Point;
			flashed : ARRAY[0..grid-1, 0..grid-1] OF BOOL;
			i,j,n,e,s,w : DINT := 0;
	END_VAR
	
	in := input;

	//Increase all
	FOR i := 0 TO grid-1 DO
		FOR j := 0 TO grid-1 DO
			flashed[i,j] := FALSE;
			/* printf('%d ', in[i,j]); */
			IF in[i,j] = 9 THEN
				//Flash
				current.x := j;
				current.y := i;
				to_flash.push(current);
			ELSE
				in[i,j] := in[i,j] + 1;
			END_IF
		END_FOR
		/* printf('$n'); */
	END_FOR

	//Now flash each point with possible ripple effects
	step := 0;
	/* printf('To flash %d$n', to_flash.counter); */
	WHILE NOT to_flash.is_empty() DO
		current := to_flash.pop();
		IF flashed[current.y,current.x] THEN
			/* printf('Skipping %d,%d$n',current.y,current.x); */
			CONTINUE;
		END_IF
		//Set the current octopus to 0
		in[current.y, current.x] := 0;
		/* printf('Flashing %d,%d$n',current.y,current.x); */
		//Flash it
		flashed[current.y, current.x] := TRUE;
		//Increase the score
		step := step + 1;
		//Check around, and add any value that has not been flashed to the stack
		n := current.y - 1;
		w := current.x - 1;
		s := current.y + 1;
		e := current.x + 1;
		//N
		IF add_adj(&in, &flashed, n,current.x) THEN
			next.x := current.x;
			next.y := n;
			to_flash.push(next);
		END_IF
		//NW
		IF add_adj(&in, &flashed, n,w) THEN
			next.x := w;
			next.y := n;
			to_flash.push(next);
		END_IF
		//W
		IF add_adj(&in, &flashed, current.y,w) THEN
			next.x := w;
			next.y := current.y;
			to_flash.push(next);
		END_IF
		//SW
		IF add_adj(&in, &flashed, s,w) THEN
			next.x := w;
			next.y := s;
			to_flash.push(next);
		END_IF
		//S
		IF add_adj(&in, &flashed, s,current.x) THEN
			next.x := current.x;
			next.y := s;
			to_flash.push(next);
		END_IF
		//SE
		IF add_adj(&in, &flashed, s,e) THEN
			next.x := e;
			next.y := s;
			to_flash.push(next);
		END_IF
		//E
		IF add_adj(&in, &flashed, current.y,e) THEN
			next.x := e;
			next.y := current.y;
			to_flash.push(next);
		END_IF
		//NE
		IF add_adj(&in, &flashed, n,e) THEN
			next.x := e;
			next.y := n;
			to_flash.push(next);
		END_IF

	END_WHILE
	input := in;
END_FUNCTION

FUNCTION add_adj : BOOL
VAR_INPUT
	in : REF_TO ARRAY[0..grid-1, 0..grid-1] OF DINT;
	flashed : REF_TO ARRAY[0..grid-1, 0..grid-1] OF BOOL;
	y,x : DINT;
END_VAR
VAR_TEMP
	current : DINT;
END_VAR

	add_adj := FALSE;

	IF x >= 0 AND x < grid AND y >= 0 AND y < grid THEN
		current := in^[y,x];
		/* printf('$tNeighbor : %d,%d = %d Flashed : %d$n',y,x,current,flashed^[y,x]); */
		IF NOT flashed^[y,x] THEN
			IF current <= 9 THEN //9 Will be flashed later
				current := current+1;
				in^[y,x] := current;
				IF current > 9 THEN
					add_adj := TRUE;
				END_IF
			END_IF
		END_IF
	END_IF

END_FUNCTION
