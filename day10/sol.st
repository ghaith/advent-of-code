FUNCTION main : DINT
	VAR_TEMP
		score  : DINT := 0;
		i : DINT := 0;
		completions : ARRAY[0..input_size-1] OF LINT;
		cmp_score : DINT := 0;
	END_VAR

	set_input();
	FOR i := 0 TO input_size-1 DO
		completions[i] := parse(&input[i]);
	END_FOR

	FOR i := 0 TO input_size-1 DO
		printf('%ld$n',completions[i]);
	END_FOR

END_FUNCTION

FUNCTION parse : LINT
VAR_INPUT
	str : REF_TO STRING[str_len];
END_VAR
VAR_TEMP
	current_str : Iterator; 
	current_char : CHAR;
	letters : Stack;
END_VAR
		parse := 0;
		/* completion_score := 0; */
		current_str.set(str);
		WHILE current_str.has_next() DO
			//For each charachter in the string
			current_char := current_str.next();
			//If the charachter is an open char, add it to the stack
			IF is_open(current_char) THEN
				letters.push(current_char);
			ELSIF is_close(current_char) THEN //If it is a closing char: peek the top stack element
				IF get_pair(current_char) = letters.peek() THEN
					//If they match, pop
					letters.pop();
				ELSE
					//Otherwise break and score
					/* parse := score(current_char); */
					RETURN;
				END_IF
			END_IF
		END_WHILE
		//Anything remaining is a completion
		WHILE NOT letters.is_empty() DO
			parse := parse * 5 + score_cmp(get_pair(letters.pop()));
		END_WHILE

END_FUNCTION

FUNCTION get_pair : CHAR
VAR_INPUT
	c : CHAR;
END_VAR
	CASE c OF
		')': get_pair := '(';
		'(': get_pair := ')';
		']': get_pair := '[';
		'[': get_pair := ']';
		'{': get_pair := '}';
		'}': get_pair := '{';
		'>': get_pair := '<';
		'<': get_pair := '>';
	END_CASE
END_FUNCTION

FUNCTION is_open : BOOL
VAR_INPUT 
	c : CHAR;
END_VAR
	CASE c OF
		'(','[','{','<' : is_open := TRUE;
	ELSE 
		is_open := FALSE;
	END_CASE
		
END_FUNCTION

FUNCTION is_close : BOOL
VAR_INPUT 
	c : CHAR;
END_VAR
	CASE c OF
		')',']','}','>' : is_close := TRUE;
	ELSE 
		is_close := FALSE;
	END_CASE
END_FUNCTION

FUNCTION score : DINT
VAR_INPUT
	c : CHAR;
END_VAR
	score := 0;
	CASE c OF
		')': score := 3;
		']': score := 57;
		'}': score := 1197;
		'>': score := 25137;
	END_CASE
END_FUNCTION

FUNCTION score_cmp : LINT
VAR_INPUT
	c : CHAR;
END_VAR
	CASE c OF
		')': score_cmp := 1;
		']': score_cmp := 2;
		'}': score_cmp := 3;
		'>': score_cmp := 4;
	END_CASE
END_FUNCTION
