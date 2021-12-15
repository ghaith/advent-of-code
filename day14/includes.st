@EXTERNAL
FUNCTION printf : DINT
VAR_INPUT
str : STRING[1024];
params : ...;
END_VAR
END_FUNCTION

FUNCTION hash : DINT
    VAR_INPUT
        str : REF_TO STRING[2];
    END_VAR
    VAR_TEMP
        ptr : REF_TO CHAR;
        lptr : LWORD;
    END_VAR
    ptr := str;
    lptr := ptr;

    hash := ptr^;
    lptr := lptr + 1;
    ptr := lptr;

    hash := hash + (ptr^ * 100);

END_FUNCTION

TYPE Insersion : STRUCT name : STRING[2]; ins : CHAR; END_STRUCT END_TYPE

FUNCTION map : __VOID
    VAR_INPUT
        arr : REF_TO ARRAY[0..10000] OF Insersion;
        key : STRING[2];
        value : CHAR;
    END_VAR
    VAR_TEMP
        h : DINT;
    END_VAR
    h := hash(&key);
    arr^[h].name := key;
    arr^[h].ins := value;
    // printf('Insersion : arr^[%d] : %s -> %c$n', h, &arr^[h].name, arr^[h].ins);
END_FUNCTION
 
FUNCTION char_at : CHAR
	VAR_INPUT
		str : REF_TO STRING;
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