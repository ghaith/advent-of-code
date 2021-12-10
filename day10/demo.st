VAR_GLOBAL CONSTANT
	str_len : DINT := 24; //Max length
	input_size : DINT := 9;
END_VAR

VAR_GLOBAL
	input : ARRAY[0..input_size-1] OF STRING[str_len];
END_VAR

FUNCTION set_input : __VOID
VAR_TEMP
	c : DINT;
END_VAR
	input[c] := '[({(<(())[]>[[{[]{<()<>>'; c := c + 1;
	input[c] := '[(()[<>])]({[<{<<[]>>('; c := c + 1;
	input[c] := '{([(<{}[<>[]}>{[]{[(<()>'; c := c + 1;
	input[c] := '(((({<>}<{<{<>}{[]{[]{}'; c := c + 1;
	input[c] := '[[<[([]))<([[{}[[()]]]'; c := c + 1;
	input[c] := '[{[{({}]{}}([{[{{{}}([]'; c := c + 1;
	input[c] := '{<[[]]>}<{[{[{[]{()[[[]'; c := c + 1;
	input[c] := '[<(<(<(<{}))><([]([]()'; c := c + 1;
	input[c] := '<{([([[(<>()){}]>(<<{{'; c := c + 1;
	input[c] := '<{([{{}}[<[[[<>{}]]]>[]]'; c := c + 1;
END_FUNCTION
