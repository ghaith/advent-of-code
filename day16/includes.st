@EXTERNAL
FUNCTION printf : DINT
VAR_INPUT
str : STRING[1024];
params : ...;
END_VAR
END_FUNCTION

FUNCTION pow : DINT
VAR_INPUT
	x,y : DINT;
END_VAR
VAR_TEMP
	i : DINT;
END_VAR
	pow := 1;
	FOR i := 1 TO y THEN
		pow := pow * x;
	END_IF
END_FUNCTION

(* Read the given array into a number *)
FUNCTION read_bits : DINT
VAR
	bits : REF_TO ARRAY[0..4] OF DINT;
END_VAR
VAR_TEMP
	i : DINT;
END_VAR
	read_bits := 0;
	FOR i := 0 TO 4 DO
		read_bits := read_bits + bits^[i] * pow(2,4-i);
	END_FOR
END_FUNCTION
