CLASS bitsteam
	VAR
		values : ARRAY[0..4096*4] OF DINT; //BOOL really
		pos : DINT;
	END_VAR

	METHOD read_hex : __VOID
	VAR_INPUT
		in : REF_TO STRING[4096];
	END_VAR
	//For each letter, find it in the array and add the string sequence to the array
	END_METHOD

	METHOD read : ARRAY[0..31] OF DINT //BOOL?
		VAR_INPUT
			num : DINT;
		END_VAR
	END_METHOD

END_CLASS

