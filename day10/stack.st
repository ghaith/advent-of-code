CLASS Stack
VAR
	arr : ARRAY[0..str_len] OF CHAR;
	counter : DINT := 0;
END_VAR

METHOD push : __VOID
	VAR_INPUT
		p : CHAR;
	END_VAR
	arr[counter] := p;
	counter := counter + 1;
END_METHOD

METHOD pop : CHAR
	counter := counter - 1;
	IF counter < 0 THEN
		counter := 0;
	END_IF
	pop := arr[counter];
END_METHOD

METHOD peek : CHAR
	peek := arr[counter - 1];
END_METHOD

METHOD is_empty : BOOL 
	is_empty := counter = 0;
END_METHOD

END_CLASS
