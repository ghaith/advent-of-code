@EXTERNAL FUNCTION printf : DINT VAR_INPUT str : STRING[1024]; params : ...; END_VAR END_FUNCTION

CLASS fish
	VAR
		age : INT;
	END_VAR

	(* Ages the fish by one day, returns its previous *)
	METHOD advance : INT
		advance := age;
		age := age - 1;
		if age = -1 THEN
			age := 6;
		END_IF
	END_METHOD
END_CLASS

CLASS world
	VAR
		fishes : ARRAY[0..1000000] OF fish;
		counter : DINT := 0;
	END_VAR

	METHOD new : __VOID
	VAR_INPUT
		age : INT;
	END_VAR
		fishes[counter].age := age;
		counter := counter + 1;
	END_METHOD

	METHOD advance : DINT
	VAR_TEMP
		i : DINT := 0;
		current_count : DINT := 0;
	END_VAR
		current_count := counter;
		printf('Current population %d$n' , counter);
		FOR i := 0 TO current_count -1 DO
			IF fishes[i].advance() = 0 THEN
					//create new fish TODO: internal method calls do not work
					/* THIS.new(8); */
					fishes[counter].age := 8;
					counter := counter + 1;
			END_IF
		END_FOR
		advance := counter;
	END_METHOD

	METHOD print : __VOID
		VAR_TEMP
			i : DINT;
		END_VAR
			FOR i := 0 TO counter DO
				printf('%d,', fishes[counter].age);
			END_FOR
			printf('$n');
	END_METHOD
END_CLASS

FUNCTION main : DINT
	VAR_TEMP
		world : world;
		i : DINT;
		population : DINT := 0;
	END_VAR
	/* world.new(3); */
	/* world.new(4); */
	/* world.new(3); */
	/* world.new(1); */
	/* world.new(2); */

world.counter := 0;
world.new(4);
world.new(3);
world.new(4);
world.new(5);
world.new(2);
world.new(1);
world.new(1);
world.new(5);
world.new(5);
world.new(3);
world.new(3);
world.new(1);
world.new(5);
world.new(1);
world.new(4);
world.new(2);
world.new(2);
world.new(3);
world.new(1);
world.new(5);
world.new(1);
world.new(4);
world.new(1);
world.new(2);
world.new(3);
world.new(4);
world.new(1);
world.new(4);
world.new(1);
world.new(5);
world.new(2);
world.new(1);
world.new(1);
world.new(3);
world.new(3);
world.new(5);
world.new(1);
world.new(1);
world.new(1);
world.new(1);
world.new(4);
world.new(5);
world.new(1);
world.new(2);
world.new(1);
world.new(2);
world.new(1);
world.new(1);
world.new(1);
world.new(5);
world.new(3);
world.new(3);
world.new(1);
world.new(1);
world.new(1);
world.new(1);
world.new(2);
world.new(4);
world.new(2);
world.new(1);
world.new(2);
world.new(3);
world.new(2);
world.new(5);
world.new(3);
world.new(5);
world.new(3);
world.new(1);
world.new(5);
world.new(4);
world.new(5);
world.new(4);
world.new(4);
world.new(4);
world.new(1);
world.new(1);
world.new(2);
world.new(1);
world.new(3);
world.new(1);
world.new(1);
world.new(4);
world.new(2);
world.new(1);
world.new(2);
world.new(1);
world.new(2);
world.new(5);
world.new(4);
world.new(2);
world.new(4);
world.new(2);
world.new(2);
world.new(4);
world.new(2);
world.new(2);
world.new(5);
world.new(1);
world.new(2);
world.new(1);
world.new(2);
world.new(1);
world.new(4);
world.new(4);
world.new(4);
world.new(3);
world.new(2);
world.new(1);
world.new(2);
world.new(4);
world.new(3);
world.new(5);
world.new(1);
world.new(1);
world.new(3);
world.new(4);
world.new(2);
world.new(3);
world.new(3);
world.new(5);
world.new(3);
world.new(1);
world.new(4);
world.new(1);
world.new(1);
world.new(1);
world.new(1);
world.new(2);
world.new(3);
world.new(2);
world.new(1);
world.new(1);
world.new(5);
world.new(5);
world.new(1);
world.new(5);
world.new(2);
world.new(1);
world.new(4);
world.new(4);
world.new(4);
world.new(3);
world.new(2);
world.new(2);
world.new(1);
world.new(2);
world.new(1);
world.new(5);
world.new(1);
world.new(4);
world.new(4);
world.new(1);
world.new(1);
world.new(4);
world.new(1);
world.new(4);
world.new(2);
world.new(4);
world.new(3);
world.new(1);
world.new(4);
world.new(1);
world.new(4);
world.new(2);
world.new(1);
world.new(5);
world.new(1);
world.new(1);
world.new(1);
world.new(3);
world.new(2);
world.new(4);
world.new(1);
world.new(1);
world.new(4);
world.new(1);
world.new(4);
world.new(3);
world.new(1);
world.new(5);
world.new(3);
world.new(3);
world.new(3);
world.new(4);
world.new(1);
world.new(1);
world.new(3);
world.new(1);
world.new(3);
world.new(4);
world.new(1);
world.new(4);
world.new(5);
world.new(1);
world.new(4);
world.new(1);
world.new(2);
world.new(2);
world.new(1);
world.new(3);
world.new(3);
world.new(5);
world.new(3);
world.new(2);
world.new(5);
world.new(1);
world.new(1);
world.new(5);
world.new(1);
world.new(5);
world.new(1);
world.new(4);
world.new(4);
world.new(3);
world.new(1);
world.new(5);
world.new(5);
world.new(2);
world.new(2);
world.new(4);
world.new(1);
world.new(1);
world.new(2);
world.new(1);
world.new(2);
world.new(1);
world.new(4);
world.new(3);
world.new(5);
world.new(5);
world.new(2);
world.new(3);
world.new(4);
world.new(1);
world.new(4);
world.new(2);
world.new(4);
world.new(4);
world.new(1);
world.new(4);
world.new(1);
world.new(1);
world.new(4);
world.new(2);
world.new(4);
world.new(1);
world.new(2);
world.new(1);
world.new(1);
world.new(1);
world.new(1);
world.new(1);
world.new(1);
world.new(3);
world.new(1);
world.new(3);
world.new(3);
world.new(1);
world.new(1);
world.new(1);
world.new(1);
world.new(3);
world.new(2);
world.new(3);
world.new(5);
world.new(4);
world.new(2);
world.new(4);
world.new(3);
world.new(1);
world.new(5);
world.new(3);
world.new(1);
world.new(1);
world.new(1);
world.new(2);
world.new(1);
world.new(4);
world.new(4);
world.new(5);
world.new(1);
world.new(5);
world.new(1);
world.new(1);
world.new(1);
world.new(2);
world.new(2);
world.new(4);
world.new(1);
world.new(4);
world.new(5);
world.new(2);
world.new(4);
world.new(5);
world.new(2);
world.new(2);
world.new(2);
world.new(5);
world.new(4);
world.new(4);
	FOR i := 1 TO 80 DO
		population := world.advance();	
	END_FOR
	printf('Population %d$N', population);
END_FUNCTION
