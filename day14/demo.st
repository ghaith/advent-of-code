VAR_GLOBAL 
    insertions : ARRAY[0..10000] OF Insersion;
    polymer: STRING;
END_VAR
FUNCTION set_input : DINT
VAR_INPUT
    input : REF_TO ARRAY[0..10000] OF Insersion;
END_VAR
VAR_TEMP
    i : DINT;
END_VAR

polymer := 'NNCB';

map(input,'CH','B');
map(input,'HH','N');
map(input,'CB','H');
map(input,'NH','C');
map(input,'HB','C');
map(input,'HC','B');
map(input,'HN','C');
map(input,'NN','C');
map(input,'BH','H');
map(input,'NC','B');
map(input,'NB','B');
map(input,'BN','B');
map(input,'BB','N');
map(input,'BC','B');
map(input,'CC','N');
map(input,'CN','C');
END_FUNCTION