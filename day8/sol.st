@EXTERNAL
FUNCTION printf : DINT
	VAR_INPUT
		str : STRING[1024];
		params : ...;
	END_VAR
END_FUNCTION

VAR_GLOBAL CONSTANT
	digits_len: DINT  := 7;
	input_len : DINT := 200;
	a : DINT := 2;
	b : DINT := 3;
	c : DINT := 5;
	d : DINT := 7;
	e : DINT := 11;
	f : DINT := 13;
	g : DINT := 17;
END_VAR

FUNCTION str_len : DINT
	VAR_INPUT
		str : REF_TO STRING;
	END_VAR
	VAR_TEMP
		ptr_val : LWORD;
		ptr : REF_TO CHAR;
		current : CHAR;
		i : DINT := 0;
	END_VAR

	ptr_val := str;
	ptr := ptr_val;
	current := ptr^;

	WHILE current <> 0 AND i < digits_len DO
		i := i + 1;
		ptr_val := ptr_val + 1;
		ptr := ptr_val;
		current := ptr^;
	END_WHILE

	str_len := i;
	
END_FUNCTION

FUNCTION char_at : CHAR
	VAR_INPUT
		str : REF_TO STRING[digits_len];
		location : DINT;
	END_VAR
	VAR_TEMP
		ptr : REF_TO CHAR;
		ptr_val : LWORD;
	END_VAR
	ptr := str;
	ptr_val := ptr;
	ptr_val := ptr_val + location;
	ptr := ptr_val;
	char_at := ptr^;
END_FUNCTION

FUNCTION get_value: DINT
VAR_INPUT str : REF_TO STRING[digits_len-1]; END_VAR
VAR_TEMP i : DINT; ch: CHAR; END_VAR

get_value := 1;
FOR i := 0 TO digits_len-1 DO
	ch := char_at(str, i);
	CASE ch OF
		'a': get_value := get_value *a;
		'b': get_value := get_value *b;
		'c': get_value := get_value *c;
		'd': get_value := get_value *d;
		'e': get_value := get_value *e;
		'f': get_value := get_value *f;
		'g': get_value := get_value *g;
	END_CASE
END_FOR

END_FUNCTION

FUNCTION pow : DINT
VAR_INPUT x,y : DINT; END_VAR
VAR_TEMP i : DINT; END_VAR

pow := 1;

IF y = 0 THEN RETURN; END_IF

FOR i := 1 TO y DO
	pow := pow*x;
END_FOR

END_FUNCTION


FUNCTION solve_line : DINT
VAR_INPUT
	in : REF_TO ARRAY[0..9] OF STRING[digits_len];
	out  :REF_TO ARRAY[0..3] OF STRING[digits_len];
END_VAR
VAR_TEMP
	i,j,k,l,val,res,length : DINT := 0;
	current_string : STRING;
	digits : ARRAY[0..3] OF DINT;
	resolved : ARRAY[0..9] OF BOOL;
	string_res : ARRAY[0..9] OF STRING;

	zero,one,two,three,four,five,six,seven,eight, nine, e : DINT := 1;

END_VAR
	FOR i := 0 TO 9 DO
		resolved[i] := FALSE;
	END_FOR
	//Parse the input
	//Find the fix numbers
	FOR i := 0 TO 9 DO
		current_string := in^[i];
		length := str_len(&current_string);
		CASE length OF
			2 : 
				one := get_value(&current_string); resolved[i] := TRUE; string_res[1] := current_string;
			3 : 
				seven := get_value(&current_string); resolved[i] := TRUE; string_res[7] := current_string;
			4 : 
				four := get_value(&current_string); resolved[i] := TRUE; string_res[4] := current_string;
			7 : 
				eight := get_value(&current_string); resolved[i] := TRUE; string_res[8] := current_string;
		END_CASE
	END_FOR

	FOR i := 0 TO 9 DO
		IF NOT resolved[i] THEN 
			current_string := in^[i];
			val := get_value(&current_string);
			length := str_len(&current_string);
			CASE length OF
				5 : 
					//If we can devide by one and zeven, this a 3, otherwise a 5 or 2
					IF (val MOD seven) = 0 AND (val MOD one) = 0 THEN
						three := val; resolved[i] := TRUE; string_res[3] := current_string;
					END_IF
				6 : 
					//If we can devide by one and zeven, this a 0, if we can devide by four and zeven this is a 9 , else it is a 6
					IF (val MOD seven) = 0 AND (val MOD four) = 0 AND (val MOD one) = 0 THEN
						nine := val; resolved[i] := TRUE; string_res[9] := current_string;
					ELSIF (val MOD seven) = 0 AND (val MOD one) = 0 THEN
						zero := val; resolved[i] := TRUE; string_res[0] := current_string;
					ELSE
						six := val; resolved[i] := TRUE; string_res[6] := current_string;
					END_IF
			END_CASE
		END_IF
	END_FOR

	e := eight/nine;

	FOR i := 0 TO 9 DO
		IF NOT resolved[i] THEN 
			current_string := in^[i];
			val := get_value(&current_string);
			length := str_len(&current_string);
			IF val MOD e = 0 THEN
				two := val; resolved[i] := TRUE; string_res[2] := current_string;
			ELSE
				five := val; resolved[i] := TRUE; string_res[5] := current_string;
			END_IF
		END_IF
	END_FOR

	//Now parse the output
	res := 0;
	FOR i := 0 TO 3 DO
		current_string := out^[i];
		val := get_value(&current_string);
		k := pow(10,(3-i));
		IF val = zero THEN
			l := 0;
		ELSIF val = one THEN
			l := 1;
		ELSIF val = two THEN
			l := 2;
		ELSIF val = three THEN
			l := 3;
		ELSIF val = four THEN
			l := 4;
		ELSIF val = five THEN
			l := 5;
		ELSIF val = six THEN
			l := 6;
		ELSIF val = seven THEN
			l := 7;
		ELSIF val = eight THEN
			l := 8;
		ELSIF val = nine THEN
			l := 9;
		END_IF
		res := res + (l * k);
	END_FOR

	FOR i := 0 TO 9 DO
		IF NOT resolved[i] THEN
			printf('%s : %d unresolved $n', in, i);
		END_IF
	END_FOR

	solve_line := res;
	/* printf('line solution : %d$n', res); */
	/* printf('0 : %d, 1 : %d, 2 : %d, 3 : %d, 4 : %d, 5 : %d, 6 : %d, 7 : %d, 8 : %d, 9 : %d$n', zero, one, two, three, four, five, six, seven, eight, nine); */
	/* printf('0 : %s, 1 : %s, 2 : %s, 3 : %s, 4 : %s, 5 : %s, 6 : %s, 7 : %s, 8 : %s, 9 : %s$n', &string_res[0], &string_res[1], &string_res[2], &string_res[3], &string_res[4], &string_res[5], &string_res[6], &string_res[7], &string_res[8], &string_res[9]); */
	/* printf('0 : %s, 1 : %s, 2 : %s, 3 : %s, 4 : %s, 5 : %s, 6 : %s, 7 : %s, 8 : %s, 9 : %s$n', &in^[0], &in^[1], &in^[2], &in^[3], &in^[4], &in^[5], &in^[6], &in^[7], &in^[8], &in^[9]); */

END_FUNCTION

FUNCTION main : DINT
VAR_TEMP
	input : ARRAY[0..input_len - 1] OF ARRAY[0..9] OF STRING[digits_len];
	output : ARRAY[0..input_len - 1] OF ARRAY[0..3] OF STRING[digits_len];
	temp_in : ARRAY[0..9] OF STRING[digits_len];
	temp_out : ARRAY[0..3] OF STRING[digits_len];
	i,j : DINT := 0;
	count,len: DINT := 0;
	val : STRING[digits_len];
END_VAR

/* add_in(&input[i], 'be', 'cfbegad', 'cbdgef', 'fgaecd', 'cgeb', 'fdcge', 'agebfd', 'fecdb', 'fabcd', 'edb'); */
/*  add_out(&output[i],'fdgacbe', 'cefdb', 'cefbgd', 'gcbe'); i := i+1; */
/* add_in(&input[i], 'edbfga', 'begcd', 'cbg', 'gc', 'gcadebf', 'fbgde', 'acbgfd', 'abcde', 'gfcbed', 'gfec'); */
/*  add_out(&output[i],'fcgedb', 'cgb', 'dgebacf', 'gc'); i := i+1; */
/* add_in(&input[i], 'fgaebd', 'cg', 'bdaec', 'gdafb', 'agbcfd', 'gdcbef', 'bgcad', 'gfac', 'gcb', 'cdgabef'); */
/*  add_out(&output[i],'cg', 'cg', 'fdcagb', 'cbg'); i := i+1; */
/* add_in(&input[i], 'fbegcd', 'cbd', 'adcefb', 'dageb', 'afcb', 'bc', 'aefdc', 'ecdab', 'fgdeca', 'fcdbega'); */
/*  add_out(&output[i],'efabcd', 'cedba', 'gadfec', 'cb'); i := i+1; */
/* add_in(&input[i], 'aecbfdg', 'fbg', 'gf', 'bafeg', 'dbefa', 'fcge', 'gcbea', 'fcaegb', 'dgceab', 'fcbdga'); */
/*  add_out(&output[i],'gecf', 'egdcabf', 'bgf', 'bfgea'); i := i+1; */
/* add_in(&input[i], 'fgeab', 'ca', 'afcebg', 'bdacfeg', 'cfaedg', 'gcfdb', 'baec', 'bfadeg', 'bafgc', 'acf'); */
/*  add_out(&output[i],'gebdcfa', 'ecba', 'ca', 'fadegcb'); i := i+1; */
/* add_in(&input[i], 'dbcfg', 'fgd', 'bdegcaf', 'fgec', 'aegbdf', 'ecdfab', 'fbedc', 'dacgb', 'gdcebf', 'gf'); */
/*  add_out(&output[i],'cefg', 'dcbef', 'fcge', 'gbcadfe'); i := i+1; */
/* add_in(&input[i], 'bdfegc', 'cbegaf', 'gecbf', 'dfcage', 'bdacg', 'ed', 'bedf', 'ced', 'adcbefg', 'gebcd'); */
/*  add_out(&output[i],'ed', 'bcgafe', 'cdgba', 'cbgef'); i := i+1; */
/* add_in(&input[i], 'egadfb', 'cdbfeg', 'cegd', 'fecab', 'cgb', 'gbdefca', 'cg', 'fgcdab', 'egfdb', 'bfceg'); */
/*  add_out(&output[i],'gbdfcae', 'bgc', 'cg', 'cgb'); i := i+1; */
/* add_in(&input[i], 'gcafb', 'gcf', 'dcaebfg', 'ecagb', 'gf', 'abcdeg', 'gaef', 'cafbge', 'fdbac', 'fegbdc'); */
/*  add_out(&output[i],'fgae', 'cfgab', 'fg', 'bagce'); i := i+1; */

add_in(&input[i], 'cdbga', 'acbde', 'eacdfbg', 'adbgf', 'gdebcf', 'bcg', 'decabf', 'cg', 'ebdgac', 'egca');
add_out(&output[i], 'geac', 'ceag', 'faedcb', 'cg');
i := i+1;

add_in(&input[i], 'edbcfag', 'ebdca', 'ebgad', 'dagbef', 'cfbed', 'adcg', 'dcgeab', 'ac', 'cae', 'cgabef');
add_out(&output[i], 'gacd', 'ac', 'dgac', 'ebdfc');
i := i+1;

add_in(&input[i], 'gceafb', 'fcabedg', 'ebfd', 'bd', 'ebacf', 'bafcde', 'daecbg', 'dabfc', 'abd', 'acfgd');
add_out(&output[i], 'adb', 'fagdc', 'bd', 'agfbec');
i := i+1;

add_in(&input[i], 'abd', 'cebd', 'bd', 'gcbaf', 'dcafb', 'dface', 'ecgfbda', 'ecdfba', 'fdegca', 'dbafeg');
add_out(&output[i], 'dbecfag', 'bd', 'decb', 'dbgfcea');
i := i+1;

add_in(&input[i], 'ecdagfb', 'eb', 'egfcb', 'gcdbfa', 'dcfeg', 'aecb', 'fabcg', 'afebgd', 'ebg', 'agecbf');
add_out(&output[i], 'bge', 'be', 'abcfge', 'bfedacg');
i := i+1;

add_in(&input[i], 'dbcf', 'gfc', 'fcbdaeg', 'cf', 'bgfced', 'begacd', 'dbgec', 'gdfea', 'cfdeg', 'bafgce');
add_out(&output[i], 'egcfdb', 'ebdgc', 'gadbcfe', 'bedfacg');
i := i+1;

add_in(&input[i], 'efbda', 'dbf', 'fb', 'fegdabc', 'dagbce', 'fcade', 'dfbceg', 'gbadfe', 'abdge', 'gbfa');
add_out(&output[i], 'bafg', 'gbaf', 'bf', 'fb');
i := i+1;

add_in(&input[i], 'afbegc', 'bgcfde', 'dc', 'edagf', 'fcadgb', 'gacbf', 'dgc', 'fdagc', 'dgebfca', 'dcab');
add_out(&output[i], 'dc', 'dcg', 'bgcfa', 'adbcfg');
i := i+1;

add_in(&input[i], 'gfced', 'ebcg', 'fdgceab', 'gdfbe', 'dfcbea', 'ce', 'dfegba', 'dce', 'fbgecd', 'dcgaf');
add_out(&output[i], 'bceg', 'fbegad', 'ecagbfd', 'dfgec');
i := i+1;

add_in(&input[i], 'agbec', 'dgef', 'gfbec', 'ef', 'gfadbc', 'cfgdbe', 'gedfcba', 'cefbda', 'cdfgb', 'bef');
add_out(&output[i], 'bdeafgc', 'gcbdf', 'febdagc', 'fgde');
i := i+1;

add_in(&input[i], 'egabc', 'dcgbef', 'efdbac', 'fdaceg', 'af', 'eacbf', 'cagedfb', 'abdf', 'fac', 'bfdce');
add_out(&output[i], 'bedcgaf', 'dabf', 'gfbdaec', 'afebc');
i := i+1;

add_in(&input[i], 'dbcf', 'efgdca', 'gacdfb', 'bc', 'abfcg', 'dafcbge', 'gbeaf', 'bac', 'gdecba', 'dgfca');
add_out(&output[i], 'gcfab', 'dbgace', 'abcfg', 'dbegfca');
i := i+1;

add_in(&input[i], 'aecbgd', 'bgadf', 'bgdcfea', 'bfgdea', 'egaf', 'gfd', 'eabdg', 'gf', 'adbcf', 'cbgfde');
add_out(&output[i], 'fgea', 'fgd', 'dfg', 'feag');
i := i+1;

add_in(&input[i], 'ecdab', 'agcdb', 'adfcegb', 'cadgeb', 'acfdg', 'fgdcbe', 'gbd', 'bg', 'aegb', 'befacd');
add_out(&output[i], 'bgecdaf', 'bgfedca', 'ebdac', 'dacbeg');
i := i+1;

add_in(&input[i], 'acfge', 'bcfaedg', 'fb', 'adegfb', 'bcgfae', 'ecfadg', 'fbac', 'fbe', 'ecbfg', 'dgbce');
add_out(&output[i], 'efgbac', 'bfe', 'afegc', 'cbedg');
i := i+1;

add_in(&input[i], 'afgec', 'gefbd', 'edcb', 'edcabgf', 'dcg', 'cdfebg', 'fgbade', 'gabfcd', 'edcgf', 'cd');
add_out(&output[i], 'fagdbe', 'gdcbfe', 'gecaf', 'egfac');
i := i+1;

add_in(&input[i], 'ce', 'ebadg', 'ebc', 'agfcb', 'cdagbe', 'degbfa', 'edcabf', 'dcge', 'gebac', 'egadbcf');
add_out(&output[i], 'ec', 'afebdg', 'gefbad', 'ec');
i := i+1;

add_in(&input[i], 'ebagcf', 'db', 'bfegad', 'gadfb', 'eabfg', 'gebd', 'edbafc', 'dfcgaeb', 'bdf', 'dfcga');
add_out(&output[i], 'cdgaf', 'db', 'adbfegc', 'egdb');
i := i+1;

add_in(&input[i], 'gefbcd', 'fgcbd', 'fca', 'gcdfea', 'agfb', 'ecafgdb', 'af', 'dabfc', 'acbde', 'gbfdca');
add_out(&output[i], 'dgbefca', 'bgedcf', 'debfcg', 'gfaebdc');
i := i+1;

add_in(&input[i], 'debcf', 'degcfa', 'fdgaeb', 'gcdbea', 'cbga', 'cdbeg', 'decga', 'ebg', 'gb', 'dabcfeg');
add_out(&output[i], 'abgecd', 'bg', 'gcbade', 'baefdgc');
i := i+1;

add_in(&input[i], 'gdcbe', 'ga', 'gcae', 'cgdba', 'fgbade', 'fcbedag', 'abfcd', 'gba', 'dacgbe', 'fdbcge');
add_out(&output[i], 'abg', 'dabcg', 'bcfad', 'bga');
i := i+1;

add_in(&input[i], 'dagef', 'geab', 'agdfbe', 'dceaf', 'gcdbef', 'egbdfca', 'fabgd', 'eg', 'egf', 'bcgfad');
add_out(&output[i], 'dgafb', 'ge', 'gfdae', 'aedfg');
i := i+1;

add_in(&input[i], 'afbecdg', 'cebga', 'abdcge', 'eadcb', 'gbe', 'dbcg', 'befadc', 'fcaeg', 'bg', 'efbdga');
add_out(&output[i], 'gb', 'bfcdae', 'bg', 'bge');
i := i+1;

add_in(&input[i], 'dagbcf', 'debfgc', 'aegc', 'bag', 'abgde', 'dbacge', 'dfaebcg', 'bdecg', 'ag', 'adfbe');
add_out(&output[i], 'ga', 'gcaefdb', 'gba', 'bdgaec');
i := i+1;

add_in(&input[i], 'abdecf', 'fcdeb', 'dfca', 'bdecg', 'fcb', 'cf', 'febad', 'gbafec', 'dgfbcea', 'gadfeb');
add_out(&output[i], 'dcbfe', 'cfb', 'adfc', 'adfc');
i := i+1;

add_in(&input[i], 'dfgcbe', 'dfcbgae', 'dfagb', 'geabdc', 'cfg', 'cgdbf', 'cbfe', 'bdcge', 'cf', 'gdeafc');
add_out(&output[i], 'fdaceg', 'bfec', 'fcbe', 'fdgbc');
i := i+1;

add_in(&input[i], 'degfbc', 'ab', 'cfbgade', 'eabc', 'dcbgfa', 'gab', 'cbdega', 'eagdf', 'cegbd', 'abegd');
add_out(&output[i], 'ab', 'dfecbag', 'ba', 'ab');
i := i+1;

add_in(&input[i], 'efgac', 'dceagbf', 'faebc', 'efg', 'fg', 'gdeacf', 'gacdeb', 'gbdfea', 'gfdc', 'dagce');
add_out(&output[i], 'fg', 'efacg', 'becaf', 'gfcaebd');
i := i+1;

add_in(&input[i], 'adgb', 'befgcd', 'ceafg', 'ebcafd', 'agdfbe', 'fageb', 'gbdfe', 'ba', 'edafbgc', 'eba');
add_out(&output[i], 'ecdgfb', 'befdga', 'badgef', 'bea');
i := i+1;

add_in(&input[i], 'fdcabe', 'bdfaecg', 'dage', 'acefg', 'ae', 'fgcba', 'egdcf', 'eaf', 'adgcfe', 'gbcfde');
add_out(&output[i], 'fdceg', 'eaf', 'aef', 'bfadecg');
i := i+1;

add_in(&input[i], 'abgdc', 'da', 'gadbec', 'gdbcf', 'dag', 'egbac', 'dcea', 'becfga', 'gafebd', 'dcbgafe');
add_out(&output[i], 'acgbde', 'gdfabe', 'dga', 'dag');
i := i+1;

add_in(&input[i], 'cd', 'acd', 'eabdf', 'gadfebc', 'cdaegf', 'beagc', 'bfcd', 'gbedaf', 'bdace', 'bdceaf');
add_out(&output[i], 'bdfc', 'debfac', 'cad', 'cda');
i := i+1;

add_in(&input[i], 'geabcf', 'fcg', 'fcaeb', 'aefcgd', 'gfbed', 'defcgab', 'gc', 'gcefb', 'cdeabf', 'acbg');
add_out(&output[i], 'gc', 'dgacef', 'gc', 'geadcf');
i := i+1;

add_in(&input[i], 'cbedgf', 'febad', 'faec', 'bfdca', 'ebf', 'ef', 'daefbgc', 'gbead', 'gfcbad', 'eafcdb');
add_out(&output[i], 'gfadbc', 'fe', 'fadcb', 'ef');
i := i+1;

add_in(&input[i], 'egfbac', 'fbadec', 'cged', 'dbgfec', 'fde', 'ed', 'abfgd', 'becgf', 'acdegbf', 'efdgb');
add_out(&output[i], 'fde', 'cagfbde', 'ecdg', 'dcge');
i := i+1;

add_in(&input[i], 'gbadf', 'bdagef', 'cdgb', 'dbgcaf', 'bc', 'cedfa', 'ebgadcf', 'begfca', 'cab', 'dafbc');
add_out(&output[i], 'bcdfga', 'cfaed', 'cgbd', 'dfcab');
i := i+1;

add_in(&input[i], 'fcgdba', 'abdef', 'dbfce', 'efc', 'fbeacdg', 'gedc', 'gbfced', 'gacbef', 'ce', 'fgcdb');
add_out(&output[i], 'afedb', 'fec', 'fce', 'dbfcge');
i := i+1;

add_in(&input[i], 'bef', 'cfae', 'adefbc', 'afdgebc', 'fabed', 'fcebdg', 'fdbac', 'fbdgac', 'ef', 'gedab');
add_out(&output[i], 'gfdabec', 'afce', 'fe', 'cbgadf');
i := i+1;

add_in(&input[i], 'gabe', 'ceg', 'fgace', 'fbedacg', 'ebafc', 'ge', 'ebgfca', 'gdbcfe', 'gcadf', 'cabfde');
add_out(&output[i], 'dacefb', 'gfcdbe', 'cge', 'becgdf');
i := i+1;

add_in(&input[i], 'ebgcad', 'dcagfeb', 'dacg', 'gfabe', 'gbedcf', 'gaedb', 'acbde', 'bcefda', 'dbg', 'dg');
add_out(&output[i], 'gdcbea', 'bdg', 'agedb', 'becdfag');
i := i+1;

add_in(&input[i], 'ebfag', 'agdebcf', 'gedcaf', 'cefga', 'gdcbaf', 'efdba', 'acebfg', 'bg', 'fbg', 'cbeg');
add_out(&output[i], 'bgf', 'gceb', 'gfb', 'ebcg');
i := i+1;

add_in(&input[i], 'bcaedg', 'ecf', 'dgfe', 'cegad', 'caefg', 'gdbaecf', 'ef', 'cgedfa', 'dfecab', 'bfacg');
add_out(&output[i], 'edcag', 'geacd', 'fec', 'edgf');
i := i+1;

add_in(&input[i], 'facdeg', 'gb', 'abfegd', 'eadfg', 'bgfd', 'bcead', 'ebg', 'cebagf', 'gabed', 'gbcafed');
add_out(&output[i], 'dbagfe', 'fgdb', 'aegfd', 'fbdg');
i := i+1;

add_in(&input[i], 'aedgcb', 'cdg', 'fgaced', 'afbdg', 'fagec', 'dbagfce', 'egbacf', 'decf', 'gafdc', 'cd');
add_out(&output[i], 'dc', 'gcd', 'cd', 'cgefba');
i := i+1;

add_in(&input[i], 'ecbf', 'bcadf', 'afecbd', 'be', 'bed', 'gacfdb', 'gdbeaf', 'cbdea', 'becdgaf', 'aedcg');
add_out(&output[i], 'cdaeg', 'bde', 'bfec', 'dbefca');
i := i+1;

add_in(&input[i], 'feacg', 'cfgebd', 'dfaceg', 'adbcg', 'cegfab', 'bagec', 'bedfgac', 'befa', 'eb', 'geb');
add_out(&output[i], 'acbfeg', 'be', 'ceafg', 'fbae');
i := i+1;

add_in(&input[i], 'cdgbfa', 'cbfea', 'efga', 'becdf', 'caf', 'gbcaed', 'bgefca', 'af', 'cegdfba', 'agbec');
add_out(&output[i], 'fage', 'fa', 'cfa', 'fgcbea');
i := i+1;

add_in(&input[i], 'bdagc', 'fecdb', 'bfeacd', 'gaedfb', 'gfcdbe', 'afd', 'af', 'ecaf', 'edcafbg', 'afdbc');
add_out(&output[i], 'fda', 'fegacbd', 'dgabc', 'fabcd');
i := i+1;

add_in(&input[i], 'gfecba', 'fbaecd', 'bagf', 'gcefa', 'gac', 'ag', 'egbacdf', 'dcabeg', 'fecgd', 'efabc');
add_out(&output[i], 'edbcag', 'efacg', 'gafb', 'gacfbe');
i := i+1;

add_in(&input[i], 'aecdfb', 'adegf', 'gbcdaf', 'egfdc', 'gfa', 'eagb', 'ga', 'gbaefd', 'gfedabc', 'fadbe');
add_out(&output[i], 'gfedc', 'cdafbe', 'edagcbf', 'edgbcfa');
i := i+1;

add_in(&input[i], 'eacbd', 'fbcegad', 'efdcb', 'eafbdg', 'eabcdg', 'cad', 'ca', 'gcbadf', 'gdbae', 'gcea');
add_out(&output[i], 'dac', 'dbegfca', 'cdbea', 'dca');
i := i+1;

add_in(&input[i], 'beg', 'bfadeg', 'bfgcde', 'egdacbf', 'ebagf', 'caefg', 'eadb', 'abdgf', 'eb', 'abfgdc');
add_out(&output[i], 'bge', 'eabd', 'dbfgce', 'edab');
i := i+1;

add_in(&input[i], 'fadceb', 'cef', 'edac', 'ec', 'efabcg', 'fcdbg', 'befda', 'bgdefac', 'befdga', 'ecbfd');
add_out(&output[i], 'aecd', 'fgeacdb', 'ce', 'ecbadfg');
i := i+1;

add_in(&input[i], 'fdagbc', 'fcgebda', 'dcae', 'dgceb', 'abged', 'dc', 'cdb', 'gcebf', 'aefdgb', 'dcbaeg');
add_out(&output[i], 'afdbgce', 'bdgcea', 'ceda', 'efbgcad');
i := i+1;

add_in(&input[i], 'dcbage', 'bdefag', 'cafgd', 'cbef', 'bdf', 'cefadb', 'dbcfa', 'bf', 'ebadfcg', 'bcead');
add_out(&output[i], 'bgeacd', 'bafdc', 'fb', 'efcb');
i := i+1;

add_in(&input[i], 'fbgac', 'fbg', 'abfcdg', 'gefdac', 'bg', 'efgbda', 'dbgc', 'dagcf', 'bcefgad', 'cfbae');
add_out(&output[i], 'gb', 'afbdcg', 'ebgcadf', 'dgafebc');
i := i+1;

add_in(&input[i], 'gedfb', 'fbcea', 'gbeaf', 'gcfeba', 'bdgceaf', 'fedagc', 'gae', 'adcebf', 'ga', 'acbg');
add_out(&output[i], 'ga', 'cdabfe', 'ag', 'cfeab');
i := i+1;

add_in(&input[i], 'aefcd', 'efbadc', 'bedc', 'fcgbda', 'deafb', 'adgcfe', 'fdb', 'efbag', 'gafdebc', 'bd');
add_out(&output[i], 'bedgcaf', 'bd', 'bcadfg', 'cebd');
i := i+1;

add_in(&input[i], 'adfcge', 'gfadc', 'dcfab', 'gecd', 'fbaedg', 'adegfbc', 'cefag', 'baecgf', 'gd', 'fgd');
add_out(&output[i], 'cdge', 'adfcb', 'cgde', 'gd');
i := i+1;

add_in(&input[i], 'ef', 'aef', 'adcfe', 'cdfbga', 'bcfe', 'bcfeda', 'dabfc', 'fagcdbe', 'bedfag', 'adceg');
add_out(&output[i], 'bfdca', 'faecbdg', 'fe', 'dgfabe');
i := i+1;

add_in(&input[i], 'gcefdb', 'acgeb', 'dfage', 'dfcegab', 'gcdea', 'edc', 'gdaebf', 'adfgce', 'dc', 'dacf');
add_out(&output[i], 'afdgbe', 'cafdegb', 'dbgcaef', 'aefdgb');
i := i+1;

add_in(&input[i], 'afebd', 'dbeag', 'efacbdg', 'bdeafc', 'gfdcab', 'fdge', 'gad', 'ecbga', 'gd', 'adegfb');
add_out(&output[i], 'dga', 'badfgc', 'bedag', 'dag');
i := i+1;

add_in(&input[i], 'agfdce', 'ecagdb', 'fdbac', 'fdeca', 'egafd', 'ce', 'gbacfed', 'begfad', 'efgc', 'aec');
add_out(&output[i], 'ecfg', 'ce', 'ce', 'daegbfc');
i := i+1;

add_in(&input[i], 'cabged', 'fabge', 'afd', 'facbgd', 'cdgba', 'cfdg', 'fd', 'baecdf', 'bfdgeca', 'gbafd');
add_out(&output[i], 'efcadb', 'dfcg', 'fcadebg', 'cfeadgb');
i := i+1;

add_in(&input[i], 'gabfc', 'aefdb', 'adc', 'fcdbae', 'cgdebaf', 'cefgda', 'cbed', 'bgfeda', 'acdbf', 'cd');
add_out(&output[i], 'daebfg', 'dgceaf', 'cd', 'cd');
i := i+1;

add_in(&input[i], 'acgbde', 'cdabgfe', 'gae', 'bfcgda', 'badcg', 'baed', 'gbeca', 'cgfeb', 'ecdfga', 'ae');
add_out(&output[i], 'aefdcg', 'bdae', 'eag', 'cgbafde');
i := i+1;

add_in(&input[i], 'bfcega', 'fagdc', 'egfacdb', 'efbd', 'dfebag', 'adegb', 'dagfe', 'ef', 'efg', 'begacd');
add_out(&output[i], 'debf', 'cadgf', 'abgecf', 'deafg');
i := i+1;

add_in(&input[i], 'gd', 'gdabc', 'gdfa', 'gbd', 'gbdacf', 'cdebafg', 'fcdebg', 'dbcfea', 'agbec', 'cfdba');
add_out(&output[i], 'bdg', 'befdgc', 'acbeg', 'dagf');
i := i+1;

add_in(&input[i], 'gbce', 'gef', 'edgcbf', 'cefdga', 'fgabd', 'eg', 'befgd', 'bacedf', 'fdcbe', 'dgcefab');
add_out(&output[i], 'gfe', 'egf', 'cgeb', 'edfcb');
i := i+1;

add_in(&input[i], 'eb', 'fcdgb', 'acfge', 'edgcabf', 'fbcaed', 'bfcdge', 'bdge', 'fcbge', 'fbdcga', 'ceb');
add_out(&output[i], 'ecb', 'fcedbag', 'ecb', 'efgbdc');
i := i+1;

add_in(&input[i], 'gcea', 'caf', 'fcdebga', 'ac', 'cbdafe', 'gdfbec', 'egfcda', 'dcagf', 'dbafg', 'fgecd');
add_out(&output[i], 'facgd', 'fbcdea', 'ebcgfd', 'decgf');
i := i+1;

add_in(&input[i], 'fbca', 'adbcef', 'becgd', 'bcdae', 'acdfgeb', 'cfgdae', 'ab', 'gaebdf', 'abe', 'fadce');
add_out(&output[i], 'fdagec', 'fcebad', 'daceb', 'ab');
i := i+1;

add_in(&input[i], 'ca', 'afgbe', 'fdeagcb', 'fabdge', 'gbfac', 'bcgdf', 'bagcef', 'afc', 'dcgafe', 'acbe');
add_out(&output[i], 'ca', 'dgbfc', 'bace', 'afc');
i := i+1;

add_in(&input[i], 'dce', 'fgbcead', 'fgecad', 'fedcab', 'cgae', 'febdg', 'fbacgd', 'dfacg', 'egdfc', 'ec');
add_out(&output[i], 'cbegfad', 'ecga', 'efcdg', 'gfcbad');
i := i+1;

add_in(&input[i], 'dg', 'gcedbf', 'gdb', 'febdc', 'adbcfe', 'cbgae', 'gfde', 'dgcbe', 'gdacbf', 'bcgafde');
add_out(&output[i], 'fbceda', 'gd', 'cbefad', 'cebagdf');
i := i+1;

add_in(&input[i], 'bdg', 'egdfab', 'cgadf', 'adbefc', 'cadbe', 'aedgcb', 'gbacd', 'gcfbdea', 'gb', 'gebc');
add_out(&output[i], 'gbd', 'cbge', 'gceabd', 'gfacd');
i := i+1;

add_in(&input[i], 'edgfba', 'cfbgae', 'dfbgace', 'egcfbd', 'efdc', 'cf', 'cgf', 'gdebf', 'fdbgc', 'cdbag');
add_out(&output[i], 'fdgbea', 'cadgb', 'dfeabgc', 'fc');
i := i+1;

add_in(&input[i], 'ce', 'bfcdae', 'egfabd', 'cef', 'begc', 'gdebcfa', 'abfeg', 'cfbgae', 'afdgc', 'agcfe');
add_out(&output[i], 'gfabed', 'fec', 'agcbef', 'fce');
i := i+1;

add_in(&input[i], 'acfe', 'ecg', 'cdaebg', 'bfgde', 'gbcfe', 'agcfb', 'cfdagb', 'ce', 'agecfb', 'cafgedb');
add_out(&output[i], 'cge', 'face', 'cge', 'fcebga');
i := i+1;

add_in(&input[i], 'gbeda', 'baegf', 'dgb', 'dg', 'edacbg', 'afgcdb', 'cdfbae', 'afcdgeb', 'dgce', 'cadeb');
add_out(&output[i], 'dbg', 'debacf', 'bgd', 'edabc');
i := i+1;

add_in(&input[i], 'afcdgb', 'fbdceg', 'edcgfa', 'fbc', 'gfbac', 'cbaeg', 'bf', 'gfdca', 'bfad', 'fbcgeda');
add_out(&output[i], 'gecdabf', 'cfb', 'dabf', 'acgfd');
i := i+1;

add_in(&input[i], 'af', 'gfcea', 'afg', 'fbgecd', 'bgcafed', 'bgeca', 'gcadef', 'faed', 'cgfbda', 'cgfed');
add_out(&output[i], 'facedg', 'fead', 'edgcaf', 'fdcabg');
i := i+1;

add_in(&input[i], 'fcadbeg', 'fag', 'egcfab', 'efadg', 'fbdgce', 'dgacef', 'gedab', 'afdc', 'gefcd', 'af');
add_out(&output[i], 'adgeb', 'gaf', 'afcd', 'afdc');
i := i+1;

add_in(&input[i], 'deacgbf', 'bedgaf', 'gbdf', 'fdeba', 'bef', 'bcfage', 'edbca', 'bf', 'fegad', 'dacegf');
add_out(&output[i], 'fdacge', 'edfag', 'cdefga', 'febgac');
i := i+1;

add_in(&input[i], 'bafecg', 'cfdba', 'dagcbe', 'aeb', 'cadeg', 'fagecbd', 'deafgc', 'gdbe', 'debac', 'be');
add_out(&output[i], 'ebadgc', 'aeb', 'eb', 'eab');
i := i+1;

add_in(&input[i], 'fgad', 'gbadce', 'abd', 'gfedbc', 'cfgeadb', 'ebcaf', 'abdfc', 'fbcdg', 'ad', 'fgdcab');
add_out(&output[i], 'da', 'fdag', 'cedgfb', 'gcbdef');
i := i+1;

add_in(&input[i], 'dfcbe', 'cf', 'cef', 'fdgc', 'cdbeg', 'cfdgbe', 'cegdab', 'fgabecd', 'agfcbe', 'bedfa');
add_out(&output[i], 'cef', 'fdgc', 'adfecgb', 'adcfgeb');
i := i+1;

add_in(&input[i], 'efcdg', 'afbd', 'bdcafg', 'bfcaedg', 'bdc', 'db', 'bdgaec', 'caegfb', 'bdgcf', 'gfcba');
add_out(&output[i], 'gfdbc', 'db', 'fagcb', 'dcb');
i := i+1;

add_in(&input[i], 'bdegfc', 'gd', 'gfacb', 'fcegba', 'fgd', 'cfagd', 'efdbacg', 'edacf', 'adgfbc', 'gbda');
add_out(&output[i], 'edacf', 'gabd', 'gd', 'gd');
i := i+1;

add_in(&input[i], 'dfb', 'caebd', 'dfabe', 'abegf', 'fadbeg', 'agcfbe', 'cbadgf', 'df', 'fdaecgb', 'dfeg');
add_out(&output[i], 'bgcdaf', 'fegd', 'df', 'gcbeaf');
i := i+1;

add_in(&input[i], 'acfdbe', 'cfd', 'fbeac', 'cd', 'acde', 'gbcadf', 'dgacfbe', 'egfdb', 'fceabg', 'bcefd');
add_out(&output[i], 'eacd', 'dcf', 'gebfd', 'dc');
i := i+1;

add_in(&input[i], 'ebg', 'cedfag', 'gb', 'feagd', 'gfdbce', 'begcdaf', 'fagb', 'bdaeg', 'dabec', 'dbfage');
add_out(&output[i], 'fgba', 'bgeadf', 'bedgfa', 'gabf');
i := i+1;

add_in(&input[i], 'gdafcbe', 'eag', 'daebf', 'aefdg', 'fecgd', 'ga', 'fegacd', 'cagf', 'debcfg', 'gedacb');
add_out(&output[i], 'cdefga', 'defcg', 'ga', 'gdaecf');
i := i+1;

add_in(&input[i], 'dgea', 'gcaebf', 'caefgdb', 'edbcga', 'ced', 'ed', 'cabdef', 'gcabe', 'gdcfb', 'gedcb');
add_out(&output[i], 'daegcfb', 'gdcbf', 'cfeadgb', 'de');
i := i+1;

add_in(&input[i], 'cdfage', 'gcbfda', 'cabdfe', 'fcb', 'bf', 'deafbcg', 'aebf', 'bfdec', 'fcead', 'dgebc');
add_out(&output[i], 'fcdageb', 'abdfcge', 'afecgdb', 'eafdgcb');
i := i+1;

add_in(&input[i], 'cfgd', 'cg', 'acg', 'bdcagf', 'agfebd', 'acgdb', 'bcdae', 'abgefc', 'gabfd', 'efabgdc');
add_out(&output[i], 'gbcda', 'cbdgefa', 'agc', 'bgdfa');
i := i+1;

add_in(&input[i], 'bfcged', 'dbgcf', 'aebcfg', 'cafdebg', 'bcg', 'acdfb', 'gc', 'edgc', 'edfgb', 'aebdfg');
add_out(&output[i], 'cbg', 'cg', 'cbagefd', 'agfebdc');
i := i+1;

add_in(&input[i], 'fecdb', 'bcfead', 'bcfda', 'ebacfg', 'fba', 'ab', 'cdabfge', 'dabe', 'adgcf', 'efgdcb');
add_out(&output[i], 'bdea', 'dbfac', 'ba', 'abde');
i := i+1;

add_in(&input[i], 'adfgb', 'begc', 'gecfdb', 'ebdafc', 'fbe', 'eb', 'beagcfd', 'efcgad', 'ecfgd', 'gdfbe');
add_out(&output[i], 'bceafd', 'fbe', 'gbfed', 'ebf');
i := i+1;

add_in(&input[i], 'gaefdc', 'gdafebc', 'dfba', 'da', 'fgdbe', 'ead', 'bgade', 'agbec', 'edfgab', 'fcegdb');
add_out(&output[i], 'cgbefd', 'ad', 'ead', 'agbec');
i := i+1;

add_in(&input[i], 'dceafg', 'fceb', 'afc', 'bcefdag', 'cgdba', 'fcbga', 'eabfcg', 'fc', 'gfaeb', 'ebafdg');
add_out(&output[i], 'debgaf', 'ecbf', 'efbc', 'agbfce');
i := i+1;

add_in(&input[i], 'adecgbf', 'aecdbg', 'cgdb', 'aegdb', 'ged', 'gd', 'afdbe', 'fecdag', 'bcefag', 'cbaeg');
add_out(&output[i], 'dg', 'eacgfbd', 'edg', 'gd');
i := i+1;

add_in(&input[i], 'dgceb', 'cgafdb', 'cbgea', 'ecgdaf', 'cgaefbd', 'ae', 'gbacf', 'age', 'acegbf', 'ebfa');
add_out(&output[i], 'cgabf', 'faeb', 'fbacg', 'abef');
i := i+1;

add_in(&input[i], 'gfec', 'dgbfcae', 'gedcb', 'efb', 'efcdbg', 'ceadbg', 'fe', 'decfb', 'fbgaed', 'dfcab');
add_out(&output[i], 'efb', 'ceabgfd', 'defbga', 'cbdge');
i := i+1;

add_in(&input[i], 'efb', 'gdcafe', 'acfbd', 'afcge', 'bgfdec', 'be', 'fcbage', 'gbea', 'bdgecfa', 'ecabf');
add_out(&output[i], 'abeg', 'bef', 'be', 'eb');
i := i+1;

add_in(&input[i], 'gbcd', 'egdafc', 'bgcdfe', 'gbf', 'gfedc', 'gfbce', 'faebc', 'gafdeb', 'gacebfd', 'gb');
add_out(&output[i], 'bgcd', 'bgfdae', 'gb', 'bdegfa');
i := i+1;

add_in(&input[i], 'cbegf', 'ga', 'fgad', 'agcef', 'aecdgf', 'cag', 'edgbca', 'gabecdf', 'eafcd', 'cefdab');
add_out(&output[i], 'fgcabed', 'ga', 'cga', 'gcfae');
i := i+1;

add_in(&input[i], 'badeg', 'ecfdbag', 'gf', 'gaf', 'bfedag', 'bgfad', 'gfeb', 'agecdb', 'facbd', 'cfeagd');
add_out(&output[i], 'agf', 'egdba', 'dbacf', 'gf');
i := i+1;

add_in(&input[i], 'abe', 'acdfegb', 'beadgc', 'bcdga', 'caedb', 'dgeb', 'ceabgf', 'be', 'dbgfca', 'cfeda');
add_out(&output[i], 'aeb', 'feabcg', 'eb', 'gdfbac');
i := i+1;

add_in(&input[i], 'bcfgd', 'cgaedfb', 'cfegab', 'gd', 'cafbd', 'dgfaeb', 'gecd', 'dfg', 'fbdceg', 'ecbgf');
add_out(&output[i], 'gfceab', 'efgabc', 'cdeg', 'bcgfade');
i := i+1;

add_in(&input[i], 'da', 'agcfb', 'edfa', 'egadfbc', 'gcdeaf', 'cegdba', 'agfcd', 'ecdfg', 'gcdfeb', 'gda');
add_out(&output[i], 'adfe', 'fedcgba', 'aedf', 'cfbdgea');
i := i+1;

add_in(&input[i], 'cdeabf', 'bcaedgf', 'dcfab', 'bfcag', 'bgdc', 'cegfa', 'gedbfa', 'bg', 'dfcgab', 'gba');
add_out(&output[i], 'gab', 'fgbac', 'fabcd', 'cfeagdb');
i := i+1;

add_in(&input[i], 'gad', 'gd', 'daecb', 'bcgdaf', 'adegb', 'cegd', 'eabgf', 'agcdbfe', 'agcebd', 'edcafb');
add_out(&output[i], 'dg', 'edgc', 'dfagcb', 'cged');
i := i+1;

add_in(&input[i], 'fbecdg', 'efbagc', 'gacfbd', 'bdfe', 'fe', 'cef', 'fceadgb', 'dgcae', 'cdefg', 'cdfbg');
add_out(&output[i], 'facbeg', 'ebcfgd', 'cadgbf', 'cfbgae');
i := i+1;

add_in(&input[i], 'abdce', 'gd', 'gebfcd', 'cadgb', 'gcd', 'bgfeadc', 'adeg', 'adbfec', 'facbg', 'gedbac');
add_out(&output[i], 'gcd', 'dbgaec', 'ebdgca', 'dacbe');
i := i+1;

add_in(&input[i], 'gfdcbe', 'adgbfc', 'fedga', 'af', 'bdaeg', 'efca', 'eabfgcd', 'fag', 'fcdge', 'dfecag');
add_out(&output[i], 'cegfbd', 'ceabgdf', 'agf', 'cfae');
i := i+1;

add_in(&input[i], 'cf', 'cafbde', 'agfdb', 'cfb', 'bdgcae', 'cebafg', 'acbde', 'bfcda', 'cefd', 'febgdac');
add_out(&output[i], 'gebfacd', 'efabcdg', 'adbcf', 'gdebfac');
i := i+1;

add_in(&input[i], 'befcgd', 'aefcbgd', 'fdcg', 'edf', 'adbecg', 'febdc', 'degabf', 'dcgbe', 'fd', 'eafbc');
add_out(&output[i], 'fde', 'edf', 'fcdg', 'df');
i := i+1;

add_in(&input[i], 'adef', 'bgdacf', 'caf', 'fgbec', 'fa', 'abgecd', 'acdbe', 'bfeca', 'agbfecd', 'dcbefa');
add_out(&output[i], 'acdeb', 'edaf', 'fdea', 'cbfedag');
i := i+1;

add_in(&input[i], 'ceafbg', 'gbacd', 'egacd', 'ea', 'fcdge', 'dabe', 'age', 'cgbdae', 'cfgbad', 'cegbdfa');
add_out(&output[i], 'gdcbea', 'adeb', 'cebgfda', 'dagfbc');
i := i+1;

add_in(&input[i], 'bcdeafg', 'gbdafc', 'ed', 'def', 'bfaed', 'dafbg', 'bdfgae', 'bdge', 'fbcea', 'edagfc');
add_out(&output[i], 'dbfeag', 'cadefg', 'de', 'dfe');
i := i+1;

add_in(&input[i], 'ebgcdf', 'acefgb', 'ca', 'cfdab', 'cab', 'adcbfe', 'debacfg', 'dfabg', 'adec', 'fecbd');
add_out(&output[i], 'bacfd', 'cba', 'bfgda', 'baegfcd');
i := i+1;

add_in(&input[i], 'gceaf', 'afdeg', 'cfaegbd', 'dabge', 'gdf', 'gacfed', 'gaecbf', 'fcgbde', 'fd', 'adcf');
add_out(&output[i], 'fecdgb', 'fd', 'fd', 'dgf');
i := i+1;

add_in(&input[i], 'bdfgac', 'bagdc', 'af', 'fadb', 'gfa', 'efgdc', 'bfeacdg', 'bfacge', 'acgdf', 'dgbaec');
add_out(&output[i], 'dgcef', 'aegcbd', 'afg', 'gfedc');
i := i+1;

add_in(&input[i], 'aedfbc', 'abdg', 'bceda', 'baegcd', 'cgdefb', 'gb', 'efcga', 'begac', 'efdbcga', 'gbe');
add_out(&output[i], 'aegdcb', 'dbface', 'gedfbc', 'gbe');
i := i+1;

add_in(&input[i], 'gdacef', 'deacg', 'fa', 'gdfbcea', 'cfgea', 'bgecf', 'fag', 'cedabg', 'gadbfc', 'dfea');
add_out(&output[i], 'eagcd', 'gbdcaf', 'fga', 'fabcdg');
i := i+1;

add_in(&input[i], 'gac', 'afbgc', 'acebf', 'bgdfa', 'gc', 'fbadgce', 'gcefad', 'cgdb', 'dbegaf', 'cabfgd');
add_out(&output[i], 'cg', 'gc', 'bacgdf', 'acg');
i := i+1;

add_in(&input[i], 'ebcdg', 'bda', 'dgfacb', 'agebdfc', 'cbdea', 'cbagef', 'da', 'cabdef', 'ebafc', 'fead');
add_out(&output[i], 'ad', 'cgbde', 'cdbeg', 'adef');
i := i+1;

add_in(&input[i], 'ed', 'adbfg', 'gbceda', 'gde', 'bgaedfc', 'dgfeb', 'abfcge', 'cbfgde', 'fced', 'begfc');
add_out(&output[i], 'gbfda', 'cgaedfb', 'egcfba', 'begcfd');
i := i+1;

add_in(&input[i], 'dfc', 'abcfed', 'cbfaeg', 'adfb', 'cedbf', 'fd', 'bfcadeg', 'cabfe', 'decbg', 'edgcaf');
add_out(&output[i], 'cbefga', 'efcdb', 'gfaecb', 'gceabf');
i := i+1;

add_in(&input[i], 'bdegf', 'dbafeg', 'db', 'efagb', 'fcbage', 'bgda', 'decfbag', 'afcebd', 'dbe', 'fedgc');
add_out(&output[i], 'adbefg', 'cdfge', 'ebd', 'gfabe');
i := i+1;

add_in(&input[i], 'ag', 'fbagcd', 'fgda', 'dacgb', 'dcebaf', 'abg', 'bcfad', 'efbdagc', 'fecgba', 'ebdcg');
add_out(&output[i], 'gab', 'gcedfba', 'dgecafb', 'fabedc');
i := i+1;

add_in(&input[i], 'ebagc', 'bdfaeg', 'ea', 'adec', 'bedcg', 'bae', 'bfgac', 'cdaegb', 'gedcbf', 'dgbacef');
add_out(&output[i], 'cefgbd', 'ea', 'cbdefg', 'bgdec');
i := i+1;

add_in(&input[i], 'ecbfd', 'egdfac', 'efagc', 'bcgaefd', 'agcd', 'gfeabd', 'dg', 'cfged', 'gfaebc', 'fgd');
add_out(&output[i], 'acdg', 'dfceb', 'cefadg', 'badfeg');
i := i+1;

add_in(&input[i], 'cdfeag', 'cgfea', 'fdgc', 'cf', 'gefdba', 'gecbadf', 'fca', 'cebga', 'gdafe', 'bcfdea');
add_out(&output[i], 'degfbca', 'fcdg', 'bdagfe', 'acf');
i := i+1;

add_in(&input[i], 'be', 'fcebga', 'dgefab', 'gdabc', 'egabc', 'febadcg', 'gfcaed', 'ecfb', 'efagc', 'egb');
add_out(&output[i], 'gaefdbc', 'fegadb', 'bfce', 'fceadg');
i := i+1;

add_in(&input[i], 'dbagf', 'bcdgfa', 'dbcfg', 'bgaefd', 'bfdaec', 'bcd', 'dc', 'egabfdc', 'gfcbe', 'cdag');
add_out(&output[i], 'gcad', 'acgd', 'dc', 'dbgfa');
i := i+1;

add_in(&input[i], 'ecadg', 'cbgad', 'adefbg', 'cdgeba', 'gae', 'gdcabf', 'dfcge', 'ae', 'bace', 'cdbgeaf');
add_out(&output[i], 'ae', 'dagce', 'ebdafgc', 'gacdbf');
i := i+1;

add_in(&input[i], 'gdecaf', 'cebdfag', 'fbega', 'bgcfde', 'dcbf', 'gdb', 'cegfd', 'gacdeb', 'db', 'bgdfe');
add_out(&output[i], 'bdg', 'db', 'gbaef', 'dfgbaec');
i := i+1;

add_in(&input[i], 'edgacfb', 'cgdfb', 'agdfc', 'dfbeca', 'fdegca', 'ag', 'eagc', 'efdagb', 'agd', 'cdeaf');
add_out(&output[i], 'ecafd', 'dag', 'adg', 'eagc');
i := i+1;

add_in(&input[i], 'fg', 'aedcbf', 'bfdac', 'fdgac', 'acdfbg', 'cedga', 'bcdgef', 'gfd', 'fbga', 'acgdbfe');
add_out(&output[i], 'efcdbg', 'dcabegf', 'dgabfce', 'bfadc');
i := i+1;

add_in(&input[i], 'efbag', 'cgafb', 'gfdeab', 'eacfdg', 'cbagfe', 'cg', 'gfc', 'gceb', 'dafecgb', 'fbadc');
add_out(&output[i], 'gcf', 'gbfac', 'fbgae', 'gebfa');
i := i+1;

add_in(&input[i], 'eacfd', 'dbfaeg', 'cbdgfa', 'badgf', 'efb', 'dfeba', 'fgceadb', 'eb', 'edbg', 'efgbca');
add_out(&output[i], 'ebafgc', 'be', 'fdeab', 'bfe');
i := i+1;

add_in(&input[i], 'dbeac', 'bcgfade', 'debafc', 'fdca', 'efcabg', 'gbead', 'bca', 'fdceb', 'gefcbd', 'ac');
add_out(&output[i], 'abc', 'acdbe', 'edagfbc', 'ac');
i := i+1;

add_in(&input[i], 'faecd', 'gcbadef', 'fdagc', 'cfg', 'fcbdeg', 'abefgd', 'gacb', 'cdfbga', 'fgbad', 'gc');
add_out(&output[i], 'bcdefag', 'gc', 'gcf', 'dfcbag');
i := i+1;

add_in(&input[i], 'dgc', 'dg', 'cbagfe', 'cdgbaf', 'adecgb', 'bacedfg', 'cbaeg', 'bcdeg', 'cefdb', 'dage');
add_out(&output[i], 'gdae', 'cadbge', 'cdg', 'gdc');
i := i+1;

add_in(&input[i], 'gfeacb', 'begafcd', 'fgbacd', 'cbafd', 'fbcaed', 'cfead', 'eaf', 'ebad', 'cdfeg', 'ea');
add_out(&output[i], 'cgbfaed', 'dacfebg', 'gcdef', 'cgedf');
i := i+1;

add_in(&input[i], 'acgfebd', 'fedbag', 'dbceg', 'badgec', 'gcda', 'efcbg', 'dce', 'bdaefc', 'dc', 'bdage');
add_out(&output[i], 'aebdfg', 'abdeg', 'edc', 'gcad');
i := i+1;

add_in(&input[i], 'bafcge', 'bgade', 'gafdb', 'dafbce', 'ebd', 'fadcebg', 'eagcb', 'agcdbe', 'ed', 'gdec');
add_out(&output[i], 'cegbaf', 'cgebda', 'ed', 'edbag');
i := i+1;

add_in(&input[i], 'bgfadc', 'bdea', 'fegcbda', 'fgdceb', 'gceaf', 'cabdge', 'gcdeb', 'gda', 'cdgea', 'da');
add_out(&output[i], 'adg', 'edabfgc', 'dfacgb', 'ecfag');
i := i+1;

add_in(&input[i], 'efbgdac', 'fceag', 'fdegba', 'gadfbc', 'debc', 'be', 'dcgbea', 'cagbe', 'abgdc', 'egb');
add_out(&output[i], 'dcbe', 'eb', 'efgcbad', 'cgeaf');
i := i+1;

add_in(&input[i], 'dabcef', 'dacgfb', 'fgcbe', 'efd', 'ed', 'ecfbgda', 'cdegf', 'dgfeca', 'daeg', 'gfcda');
add_out(&output[i], 'cfgdea', 'gdabcf', 'de', 'de');
i := i+1;

add_in(&input[i], 'gcdb', 'ebagfdc', 'fcdag', 'bdfaeg', 'badcgf', 'gdeafc', 'caebf', 'gb', 'fgbac', 'abg');
add_out(&output[i], 'fcagdbe', 'gb', 'bgdc', 'afdgc');
i := i+1;

add_in(&input[i], 'acdgf', 'beda', 'gdb', 'bfgade', 'gbfea', 'efbcgd', 'fgdab', 'cgefdba', 'db', 'cfgeab');
add_out(&output[i], 'bfaedg', 'afgdb', 'bdg', 'bd');
i := i+1;

add_in(&input[i], 'cgaef', 'eb', 'abgec', 'fbgadc', 'gebd', 'becdga', 'faedbc', 'aeb', 'bdagc', 'dgecfba');
add_out(&output[i], 'dcfabg', 'gcfea', 'bfeacd', 'eb');
i := i+1;

add_in(&input[i], 'gbcad', 'fgceab', 'fcaeb', 'faedcb', 'dfbe', 'cdafb', 'cegadbf', 'cagdef', 'dfa', 'df');
add_out(&output[i], 'fgecad', 'efacbd', 'egfcda', 'defb');
i := i+1;

add_in(&input[i], 'gdcaef', 'ebafdc', 'bgda', 'abfgecd', 'ebfda', 'ag', 'gae', 'gfdbae', 'begcf', 'gfeba');
add_out(&output[i], 'agbef', 'ga', 'feabg', 'ega');
i := i+1;

add_in(&input[i], 'aebcfg', 'dgafc', 'ba', 'dbfge', 'afbdg', 'cabdefg', 'dceagf', 'abg', 'dcba', 'dfcgab');
add_out(&output[i], 'cbefgda', 'dfgeb', 'cgdfae', 'bgafce');
i := i+1;

add_in(&input[i], 'ed', 'fcegba', 'gdae', 'adbcef', 'fdcbg', 'gefdbca', 'egfca', 'afdceg', 'dec', 'ecdfg');
add_out(&output[i], 'ecd', 'gfbdc', 'bcfgd', 'dgfce');
i := i+1;

add_in(&input[i], 'agdc', 'ecdbagf', 'gbcfa', 'gfcbad', 'dcbefg', 'adfgb', 'ecfbga', 'dbg', 'dbefa', 'gd');
add_out(&output[i], 'bdg', 'facbdeg', 'bdg', 'gdcbaf');
i := i+1;

add_in(&input[i], 'db', 'gfdeb', 'ebd', 'adbefgc', 'fgced', 'dfcgae', 'bcegad', 'egcfbd', 'afgbe', 'cdfb');
add_out(&output[i], 'aefcdg', 'fcdgbae', 'egdcf', 'cgeabd');
i := i+1;

add_in(&input[i], 'egcfa', 'cefdag', 'cb', 'cgbfea', 'bfca', 'ebdgcf', 'cbaeg', 'eadbg', 'gcb', 'ecdfabg');
add_out(&output[i], 'ceagf', 'cedbfg', 'bacf', 'bfac');
i := i+1;

add_in(&input[i], 'gfadcb', 'aedc', 'febcg', 'cd', 'dfecga', 'fcd', 'fegcd', 'gefbda', 'eadfg', 'bdcfeag');
add_out(&output[i], 'aedfg', 'fgaed', 'cd', 'fbecg');
i := i+1;

add_in(&input[i], 'adefb', 'gaecf', 'aefdbgc', 'acfdeb', 'cdabgf', 'gb', 'gbed', 'bdgefa', 'bga', 'efabg');
add_out(&output[i], 'dbfae', 'dgabcef', 'abg', 'cbgfda');
i := i+1;

add_in(&input[i], 'degcfb', 'adebgc', 'afegdbc', 'ca', 'dfgae', 'acgb', 'degac', 'cdfaeb', 'eac', 'debcg');
add_out(&output[i], 'bacged', 'gadef', 'gbac', 'gbecadf');
i := i+1;

add_in(&input[i], 'abgcdfe', 'ace', 'fcaeg', 'fgbac', 'dafe', 'deagcb', 'afgecd', 'ea', 'bcgdfe', 'gdcfe');
add_out(&output[i], 'ea', 'gaebdc', 'ecafdg', 'aefd');
i := i+1;

add_in(&input[i], 'cafedbg', 'cdbafe', 'dcfegb', 'abd', 'dfcab', 'gabdef', 'cabe', 'efdbc', 'ba', 'gfcad');
add_out(&output[i], 'ba', 'ebac', 'bad', 'aefgcdb');
i := i+1;

add_in(&input[i], 'edbgfa', 'bacdf', 'adfbce', 'caeb', 'efcdbag', 'cebdf', 'bdgfac', 'eb', 'cegfd', 'efb');
add_out(&output[i], 'ebf', 'bfeadc', 'eb', 'bfdeac');
i := i+1;

add_in(&input[i], 'cbadfe', 'fcg', 'cbafe', 'fg', 'gbecd', 'fdacbg', 'efgbc', 'fecabg', 'beadgcf', 'efga');
add_out(&output[i], 'abdfceg', 'ecbdg', 'fgceb', 'gf');
i := i+1;

add_in(&input[i], 'gbdfa', 'gfceda', 'def', 'befg', 'caebd', 'bdfea', 'fe', 'bfadcg', 'dbfgae', 'dabgcef');
add_out(&output[i], 'dcbea', 'fe', 'efgb', 'bcdea');
i := i+1;

add_in(&input[i], 'bacgd', 'gade', 'cdebgf', 'badgce', 'da', 'cedbg', 'dab', 'bfgac', 'egdacfb', 'debfca');
add_out(&output[i], 'gafbced', 'abefcgd', 'da', 'deag');
i := i+1;

add_in(&input[i], 'acbdfg', 'fd', 'aecdfgb', 'ecadf', 'dgcbae', 'cedfag', 'aecdg', 'abefc', 'egfd', 'daf');
add_out(&output[i], 'afceb', 'dfa', 'fgde', 'aefcb');
i := i+1;

add_in(&input[i], 'cdgafb', 'dcafg', 'afegc', 'gabd', 'bdefcg', 'cgd', 'gfaebdc', 'fbdeac', 'gd', 'cafdb');
add_out(&output[i], 'dg', 'dg', 'gcd', 'dgacfb');
i := i+1;

add_in(&input[i], 'geafdc', 'gecfb', 'gafcd', 'gbadfec', 'db', 'bgfeda', 'gbdfc', 'abdc', 'fdcgab', 'bdf');
add_out(&output[i], 'eagfdb', 'bgaefd', 'db', 'bdf');
i := i+1;

add_in(&input[i], 'acdf', 'adfge', 'gefcab', 'defcga', 'df', 'fgcae', 'fed', 'bcafdge', 'abdge', 'cgdbef');
add_out(&output[i], 'fd', 'fd', 'gfbaecd', 'facd');
i := i+1;

add_in(&input[i], 'cd', 'cebfd', 'defacg', 'fcd', 'gefcdab', 'abdef', 'bceafd', 'abdc', 'befgc', 'dfagbe');
add_out(&output[i], 'bdca', 'dfecb', 'feacdg', 'cfd');
i := i+1;

add_in(&input[i], 'gadef', 'fedc', 'eafgb', 'fd', 'ecadg', 'cdabfg', 'fdg', 'gceadb', 'cedgfa', 'edbgafc');
add_out(&output[i], 'bdcagf', 'df', 'egacd', 'bgaecdf');
i := i+1;

add_in(&input[i], 'dacbefg', 'ebdcgf', 'cegfda', 'fdcga', 'bfc', 'bfga', 'abcde', 'bcgadf', 'bf', 'bdcfa');
add_out(&output[i], 'fgba', 'ceafgd', 'bf', 'defbcg');
i := i+1;

add_in(&input[i], 'ac', 'efcbd', 'gedfca', 'ace', 'febcad', 'cabde', 'gcdbef', 'bgade', 'bdegacf', 'cfab');
add_out(&output[i], 'befcd', 'acbf', 'ceagbfd', 'abdecgf');
i := i+1;

add_in(&input[i], 'dbfagc', 'abdce', 'fgea', 'gab', 'ceagb', 'fbcega', 'gecdfba', 'ag', 'gfecb', 'efcgbd');
add_out(&output[i], 'cgadfb', 'aefgbc', 'gaebfc', 'efag');
i := i+1;

add_in(&input[i], 'cebfd', 'bdfeag', 'fgc', 'edgaf', 'gc', 'dgca', 'cdebafg', 'gcfde', 'geafcd', 'feacbg');
add_out(&output[i], 'fcgde', 'gcdeafb', 'adcg', 'gfdaceb');
i := i+1;

add_in(&input[i], 'gcebadf', 'cebdag', 'egcfda', 'acfd', 'cdegf', 'fgecba', 'cf', 'dgeac', 'fcg', 'fdgeb');
add_out(&output[i], 'decfga', 'fdac', 'egabcf', 'ecabdg');
i := i+1;

add_in(&input[i], 'fgabc', 'egbfcd', 'eaf', 'gead', 'dfegb', 'edgcbaf', 'agfdeb', 'acbdfe', 'ae', 'afgeb');
add_out(&output[i], 'gdebf', 'dgae', 'gebdf', 'efa');
i := i+1;

add_in(&input[i], 'gcadbe', 'bacgd', 'gcbafed', 'gdcef', 'aebfgd', 'age', 'aecgd', 'cabe', 'dfbgac', 'ae');
add_out(&output[i], 'dcgba', 'bace', 'age', 'acbe');
i := i+1;

add_in(&input[i], 'fgdca', 'gcabfd', 'dfea', 'gcefa', 'ecdgaf', 'adfbgce', 'cae', 'gecabd', 'cgebf', 'ae');
add_out(&output[i], 'ae', 'fcegb', 'acgdebf', 'acbedg');
i := i+1;

add_in(&input[i], 'acbdgfe', 'gdcfa', 'aecfg', 'abfdc', 'gd', 'fgdb', 'efbacd', 'gfdbac', 'gda', 'bcedag');
add_out(&output[i], 'dga', 'fgdb', 'bagdcf', 'gd');
i := i+1;

add_in(&input[i], 'fg', 'dagfcb', 'gfeac', 'cegba', 'dfceab', 'adfgbec', 'fged', 'gfacde', 'fcdae', 'fcg');
add_out(&output[i], 'dfge', 'fgc', 'acgef', 'gcf');
i := i+1;

add_in(&input[i], 'agfcbd', 'cbagef', 'edbfg', 'ecbgafd', 'bagec', 'fageb', 'cabdeg', 'fa', 'ecaf', 'abf');
add_out(&output[i], 'efagb', 'debgf', 'af', 'caebgf');
i := i+1;

add_in(&input[i], 'afecdg', 'decgfb', 'geabd', 'bgd', 'afbd', 'bd', 'caegb', 'fgacbed', 'feagd', 'gfaedb');
add_out(&output[i], 'gcafed', 'cebfdg', 'fadb', 'cfaedg');
i := i+1;

add_in(&input[i], 'cedfb', 'dgfeab', 'ecgba', 'fcdg', 'fgb', 'befgc', 'fdaebc', 'gfebcd', 'fg', 'adcgfbe');
add_out(&output[i], 'fdgc', 'afbdcge', 'cgdbef', 'cefbg');
i := i+1;

add_in(&input[i], 'defc', 'gebcf', 'cgdbfa', 'fc', 'cegab', 'bfdeg', 'dgcfeb', 'fgc', 'bgadfe', 'dagcfeb');
add_out(&output[i], 'fcde', 'bedgf', 'gfc', 'gfdbea');
i := i+1;

add_in(&input[i], 'badceg', 'bea', 'gbafc', 'dafge', 'cfbdga', 'geafcb', 'cfbe', 'gabfe', 'eb', 'gfcdabe');
add_out(&output[i], 'eba', 'bfce', 'fbec', 'eafcgb');
i := i+1;

add_in(&input[i], 'fbcedg', 'gf', 'aedcg', 'decbf', 'gfeabd', 'efg', 'gbcf', 'faebcd', 'eadbgfc', 'efdcg');
add_out(&output[i], 'fge', 'dgcbef', 'fge', 'cfgb');
i := i+1;

add_in(&input[i], 'cbdeg', 'bfca', 'ca', 'bgefa', 'aebgc', 'fcgaed', 'gcfbea', 'gac', 'cfegabd', 'defgba');
add_out(&output[i], 'gcaeb', 'gebfda', 'bgedfca', 'ca');
i := i+1;

add_in(&input[i], 'ecfd', 'cabdg', 'bcfeda', 'cdeab', 'ed', 'eafbgc', 'dae', 'gaebfd', 'ceafb', 'cfgdaeb');
add_out(&output[i], 'cefadb', 'befacgd', 'ecfd', 'gbfaced');
i := i+1;

add_in(&input[i], 'cgdea', 'gcfabe', 'afecgbd', 'becgdf', 'eb', 'abgce', 'abef', 'bce', 'fcgab', 'dcbfga');
add_out(&output[i], 'bgfdce', 'egcfbd', 'ebcfgd', 'ebcdafg');
i := i+1;

add_in(&input[i], 'fcbed', 'fbged', 'fdag', 'gd', 'egdfbac', 'gacdeb', 'egbaf', 'dge', 'cbeagf', 'fdbgea');
add_out(&output[i], 'deg', 'dg', 'dacegb', 'cdgabe');
i := i+1;

add_in(&input[i], 'faegcbd', 'aed', 'gfdba', 'fdce', 'gfacde', 'ed', 'adfge', 'dcegba', 'acgebf', 'fcaeg');
add_out(&output[i], 'aedfg', 'cebagf', 'de', 'de');
i := i+1;

add_in(&input[i], 'dbcega', 'geabf', 'gcebfd', 'deg', 'cfbade', 'dg', 'debgf', 'dgfc', 'dcfbe', 'ebadfcg');
add_out(&output[i], 'cdfaeb', 'deg', 'gfabe', 'gcbedf');
i := i+1;

add_in(&input[i], 'bgecd', 'bafg', 'efdab', 'ebdcaf', 'edfgab', 'gf', 'dfg', 'degbf', 'fcgeadb', 'aefgcd');
add_out(&output[i], 'gabf', 'bdgfe', 'fbdae', 'cbedfa');
i := i+1;

FOR i := 0 TO input_len - 1 DO
	/* part 1 */
	/* FOR j := 0 TO 3 DO */
	/* 	val := output[i][j]; */
	/* 	len := str_len(&val); */
	/* 	CASE len OF */
	/* 		2,3,4,7 : */
	/* 			/1* printf('len of %s, %d$n', &val, len); *1/ */
	/* 			count := count + 1; */
	/* 	END_CASE */
	/* END_FOR */
	/* part 2 */
		temp_in := input[i];
		temp_out := output[i];
		count := count + solve_line(&temp_in,&temp_out);
END_FOR

printf('Result %d$n', count);

END_FUNCTION

FUNCTION add_in : __VOID
VAR_INPUT
	arr : REF_TO ARRAY[0..9] OF STRING[digits_len];
	p0,p1,p2,p3,p4,p5,p6,p7,p8,p9 : STRING[digits_len];
END_VAR
	arr^[0] := p0;
	arr^[1] := p1;
	arr^[2] := p2;
	arr^[3] := p3;
	arr^[4] := p4;
	arr^[5] := p5;
	arr^[6] := p6;
	arr^[7] := p7;
	arr^[8] := p8;
	arr^[9] := p9;
END_FUNCTION

FUNCTION add_out : __VOID
VAR_INPUT
	arr : REF_TO ARRAY[0..3] OF STRING[digits_len];
	p1,p2,p3,p4 : STRING[digits_len];
END_VAR
	arr^[0] := p1;
	arr^[1] := p2;
	arr^[2] := p3;
	arr^[3] := p4;
END_FUNCTION
