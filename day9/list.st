(* A list that only keeps the biggest elements *)
CLASS list
VAR
	arr : ARRAY[0..2] OF DINT;
	lowestIdx : DINT := 0;
END_VAR

METHOD add : __VOID
VAR_INPUT
	val : DINT;
END_VAR
VAR_TEMP
	i, lowest : DINT := 0;
END_VAR

IF arr[lowestIdx] < val THEN
	arr[lowestIdx] := val;

	FOR i := 0 TO 2 DO
		IF arr[i] < arr[lowest] THEN
			lowest := i;
		END_IF
	END_FOR

	lowestIdx := lowest;
END_IF

END_METHOD

METHOD get : DINT
VAR_INPUT loc : DINT; END_VAR
	get := arr[loc];
END_METHOD

END_CLASS
