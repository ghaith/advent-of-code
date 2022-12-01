(* A string iterator class *)
CLASS Iterator
	VAR 
		str : REF_TO STRING; 
		counter : DINT := 0;
	END_VAR

	METHOD set : __VOID
		VAR_INPUT
			val : REF_TO STRING;
		END_VAR
		str := val;
		counter := 0;
	END_METHOD

	METHOD next : CHAR
	VAR_TEMP
		ptr : REF_TO CHAR;
		ptr_val : LWORD;
	END_VAR
		ptr := str;
		ptr_val := ptr;
		ptr_val := ptr_val + counter;
		ptr := ptr_val;
		next := ptr^;
		/* printf('Next at %d : %c$n',counter, next); */

		counter := counter + 1;
	END_METHOD

	METHOD has_next : BOOL
	VAR_TEMP
		ptr : REF_TO CHAR;
		ptr_val : LWORD;
	END_VAR
		ptr := str;
		ptr_val := ptr;
		ptr_val := ptr_val + counter;
		ptr := ptr_val;

		has_next := ptr^ <> 0 ;
	END_METHOD
		
END_CLASS

