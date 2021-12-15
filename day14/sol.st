VAR_GLOBAL
    steps : DINT;
END_VAR
FUNCTION main : DINT
    VAR_TEMP
       letter_count : ARRAY[65..90] OF LINT;
       combination_count : ARRAY[0..10000] OF LINT;
       size : LINT;
       iter : Iterator;
       current,next : CHAR;
       hash : DINT;
       i : DINT;
    END_VAR
    set_input(&insertions);
    iter.set(&polymer);
    FOR i := 65 TO 90 DO
        letter_count[i] := 0;
    END_FOR
    FOR i := 0 TO 10000 DO
        combination_count[i] := 0;
    END_FOR

    current := 0;
    next := 0;
    WHILE iter.has_next() DO
        IF next <> 0 THEN
            current := next;
        ELSE
            current := iter.next();
        END_IF

        IF iter.has_next() THEN
            next := iter.next();
        ELSE 
            next := 0;
        END_IF

        // printf('Current : %c, Next : %c$n', current, next);
        letter_count[current] := letter_count[current] + 1;
        IF next <> 0 THEN
            //Calculate hash
            hash := current;
            hash := hash + (next * 100);
            //Increment the count for this hash
            combination_count[hash] := combination_count[hash] + 1;
            // printf('Combination : %c%c: %d$n', current, next, combination_count[hash]);
        END_IF
        
    END_WHILE;
    letter_count[next] := letter_count[next] + 1;
    
    // printf('Size : %d $n', size);
    // print(&input);

    FOR steps := 0 TO 39 DO
        printf('Step : %d$n$t', steps);
        step(&letter_count, &combination_count);
        // printf('Size : %d$n', size);
        // print(&input);
    END_FOR

    
END_FUNCTION

// FUNCTION print : LWORD 
//     VAR_INPUT
//         input : REF_TO ARRAY[0..40000] OF CHAR;
//     END_VAR
//     VAR_TEMP
//         i : LWORD;
//     END_VAR
//     FOR i := 0 TO 4000 DO
//         printf('%c', polymer[i]);
//         IF polymer[i] = 0 THEN
//             EXIT;
//         END_IF
//     END_FOR
//     printf('$n');
// END_FUNCTION

FUNCTION step : LINT
    VAR_INPUT
       letter_count : REF_TO ARRAY[65..90] OF LINT;
       combination_count : REF_TO ARRAY[0..10000] OF LINT;
    END_VAR
    VAR_TEMP
        counter : ARRAY[65..90] OF LINT;
        combis : ARRAY[0..10000] OF LINT;
        i,j,max,min : LINT;
        hash_old, hash1,hash2 : DINT;
        ins : CHAR;
        ins_type : Insersion;
        combi1,combi2 : CHAR;
    END_VAR
    // printf('Entering step %d$n', steps);

    //Copy the letter counts
    // printf('Count Before : $n');
    FOR i := 65 TO 90 DO
        counter[i] := letter_count^[i];
        IF letter_count^[i] > 0 THEN
            // printf('%c : %d$n', i, counter[i]);
        END_IF
    END_FOR
    //Copy the combis
    FOR i := 0 TO 10000 DO
        combis[i] := combination_count^[i];
    END_FOR
    // IF steps > 16 THEN
        // printf('Set values $n');
    // END_IF

    //For each combi we currently have
    FOR i := 0 TO 10000 DO

        IF combination_count^[i] > 0 THEN
            //Find the next letter
            ins_type := insertions[i];
            ins := ins_type.ins;
            //Find the two new combis
            combi1 := char_at(&ins_type.name, 0);
            combi2 := char_at(&ins_type.name, 1);
            hash_old := combi1 + (combi2 * 100);
            hash1 := combi1 + (100 * ins);
            hash2 := ins + (100 * combi2);
            // IF steps > 16 THEN
                // printf('Combination %d : %s -> %c: %d$n', i, &ins_type.name, ins, combination_count^[i]);
            // END_IF
            // FOR j := 1 TO combination_count^[i] DO
                //Increment the count for that letter
                counter[ins] := counter[ins] + combination_count^[i];
                // IF steps > 16 THEN
                    // printf('127 %d$n',j);
                // END_IF
                //Decrease the old combi
                combis[hash_old] := combis[hash_old] - combination_count^[i];
                // IF steps > 16 THEN
                    // printf('136 %d$n',j);
                // END_IF
                //Increase the new combis
                // printf('New Combi 1: %c-%c$n', combi1, ins);
                combis[hash1] := combis[hash1] + combination_count^[i];
                // printf('New Combi 2: %c-%c$n', ins, combi2);
                combis[hash2] := combis[hash2] + combination_count^[i];
                // IF steps > 16 THEN
                    // printf('146 %d$n',j);
                // END_IF
            // END_FOR
            // IF steps > 16 THEN
                // printf('Exiting i:%d j:%d$n', i,j);
            // END_IF
        END_IF
    END_FOR
    // IF steps > 16 THEN
        // printf('Exiting Combi i:%d j:%d$n', i,j);
    // END_IF

    min := 16#0F_FF_FF_FF_FF_FF_FF_FF;
    max := 0;

    // printf('Count after : $n');
    FOR i := 65 TO 90 DO
        IF counter[i] <= 0 THEN
            CONTINUE;
        END_IF
        IF steps > 16 THEN
            // printf('%c : %d$n', i, counter[i]);
        END_IF
        letter_count^[i] := counter[i];
        IF max < counter[i] THEN
            max := counter[i];
        END_IF
        IF min > counter[i] THEN
            min := counter[i];
        END_IF
    END_FOR

    printf('Max : %ld, Min ; %ld, %ld$n', max, min, max - min);

    FOR i := 0 TO 10000 DO
        combination_count^[i] := combis[i];
    END_FOR


END_FUNCTION

