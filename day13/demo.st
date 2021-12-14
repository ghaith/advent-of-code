FUNCTION set_input : DINT
VAR_input
	input : REF_TO ARRAY[0..1000] OF Point;
END_VAR
VAR_TEMP i : DINT := 0; END_VAR

input^[i].x := 6; input^[i].y := 10; i := i + 1;
input^[i].x := 0; input^[i].y := 14; i := i + 1;
input^[i].x := 9; input^[i].y := 10; i := i + 1;
input^[i].x := 0; input^[i].y := 3; i := i + 1;
input^[i].x := 10; input^[i].y := 4; i := i + 1;
input^[i].x := 4; input^[i].y := 11; i := i + 1;
input^[i].x := 6; input^[i].y := 0; i := i + 1;
input^[i].x := 6; input^[i].y := 12; i := i + 1;
input^[i].x := 4; input^[i].y := 1; i := i + 1;
input^[i].x := 0; input^[i].y := 13; i := i + 1;
input^[i].x := 10; input^[i].y := 12; i := i + 1;
input^[i].x := 3; input^[i].y := 4; i := i + 1;
input^[i].x := 3; input^[i].y := 0; i := i + 1;
input^[i].x := 8; input^[i].y := 4; i := i + 1;
input^[i].x := 1; input^[i].y := 10; i := i + 1;
input^[i].x := 2; input^[i].y := 14; i := i + 1;
input^[i].x := 8; input^[i].y := 10; i := i + 1;
input^[i].x := 9; input^[i].y := 0; i := i + 1;

set_input := i;

END_FUNCTION
