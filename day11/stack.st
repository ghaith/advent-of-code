CLASS Stack
VAR
	arr : ARRAY[0..grid*grid] OF Point;
	counter : DINT := 0;
END_VAR

METHOD push : __VOID
	VAR_INPUT
		p : Point;
	END_VAR
	arr[counter] := p;
	counter := counter + 1;
END_METHOD

METHOD pop : Point
	counter := counter - 1;
	IF counter < 0 THEN
		counter := 0;
	END_IF
	pop := arr[counter];
END_METHOD

METHOD peek : Point
	peek := arr[counter - 1];
END_METHOD

METHOD is_empty : BOOL 
	is_empty := counter = 0;
END_METHOD

END_CLASS
