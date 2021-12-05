@EXTERNAL
FUNCTION printf : DINT
VAR_INPUT
	str : STRING[1024];
	params: ...;
END_VAR
END_FUNCTION

VAR_GLOBAL CONSTANT
	demo_len : DINT := 12;
	input_len : DINT := 1000;
	len : DINT := input_len;
	bit_size : DINT := 12; 
END_VAR

FUNCTION main : DINT
	calculate();
END_FUNCTION

FUNCTION calculate : DINT
	VAR 
		/* input : ARRAY[0..len - 1] OF DINT :=  [2#00100,2#11110,2#10110,2#10111,2#10101,2#01111,2#00111,2#11100,2#10000,2#11001,2#00010,2#01010]; */
		input : ARRAY[0..len] OF INT := [ 2#011000110010, 2#111011101000, 2#110100110010, 2#011010101110, 2#111010100100, 2#100111111100,
2#110001110000, 2#000100100100, 2#000110101101, 2#101011100110, 2#110011000110, 2#111100101111,
2#000011010111, 2#001111100100, 2#100010101101, 2#101100000010, 2#001100001111, 2#001001001110,
2#100100110000, 2#000000011001, 2#000111001000, 2#101000110110, 2#110011010000, 2#101110111011,
2#111000000011, 2#101100110100, 2#111110001010, 2#001101001111, 2#100101011001, 2#010101111111,
2#111100111001, 2#010100111010, 2#111110100111, 2#100101110111, 2#110001001100, 2#110111001110,
2#011111011011, 2#011111010111, 2#001100101111, 2#110111011101, 2#000110010111, 2#001100000001,
2#111101100100, 2#100111110010, 2#111010001010, 2#000010000001, 2#000011101110, 2#110011100101,
2#011101100010, 2#101100010101, 2#010110110101, 2#000010111001, 2#100111010101, 2#000101010001,
2#000000110111, 2#110010000111, 2#000101010111, 2#011100101000, 2#011111101011, 2#101001110110,
2#000000110100, 2#100101001100, 2#111100010101, 2#001000001101, 2#111101101011, 2#110101010010,
2#011101000100, 2#100000100011, 2#111110110110, 2#001010010111, 2#111001010101, 2#011011011100,
2#001010010001, 2#001101111110, 2#100100111010, 2#100011000110, 2#111010000111, 2#000111000101,
2#000110000011, 2#111000011110, 2#011110110001, 2#011111111011, 2#100001000010, 2#001011111011,
2#101111101011, 2#001111110001, 2#010001000000, 2#011001100111, 2#110100101110, 2#001001110110,
2#101110011101, 2#110011101001, 2#101111000010, 2#110000000110, 2#011000010001, 2#010001011111,
2#111000001111, 2#000101101011, 2#110011010001, 2#000011110101, 2#101010110010, 2#001111001001,
2#001011000100, 2#001001101001, 2#010011010101, 2#010011011011, 2#101101011100, 2#011111011001,
2#101011100001, 2#000100011011, 2#111011000011, 2#001001001101, 2#111110011111, 2#110101101111,
2#100100111110, 2#110000110100, 2#011010110111, 2#101000000100, 2#111110010100, 2#111111001100,
2#100101100110, 2#111111010000, 2#011011100111, 2#000111100100, 2#011011100000, 2#111011100000,
2#001001111010, 2#010111010111, 2#011100110101, 2#101010111100, 2#101111110101, 2#110101001110,
2#110000001011, 2#100111011000, 2#011010011000, 2#111101010011, 2#101011010110, 2#110110001101,
2#100111010000, 2#110100000001, 2#110001010001, 2#001000110011, 2#110010110101, 2#010000011010,
2#001010111101, 2#001000110001, 2#111111000101, 2#111101010101, 2#001000000010, 2#101010101001,
2#000000010011, 2#101111010101, 2#000100111001, 2#001111001111, 2#000100000001, 2#100010101001,
2#010011101011, 2#011001101100, 2#011001001100, 2#110010111110, 2#000000010000, 2#010010110110,
2#101101110101, 2#010001101010, 2#111001011100, 2#001100000110, 2#110001110010, 2#100001001001,
2#101011000010, 2#111011100011, 2#011101010010, 2#011000100000, 2#100000110111, 2#100100100101,
2#100110101011, 2#011101000111, 2#011001010101, 2#110011100010, 2#001100100001, 2#111000010110,
2#000110100110, 2#001001011000, 2#101000011010, 2#001101001101, 2#111110000111, 2#001110111011,
2#001111101110, 2#111000101101, 2#000111010011, 2#110101010000, 2#010101000011, 2#110011100110,
2#111001011111, 2#011101011111, 2#001000101110, 2#001111001000, 2#001111010000, 2#110010010010,
2#100010110110, 2#000011101000, 2#010001100111, 2#101100001001, 2#100000000110, 2#010101000111,
2#000001100111, 2#101010111000, 2#000101010101, 2#001011011010, 2#110011000111, 2#000101000101,
2#111111011011, 2#111001100010, 2#101111110110, 2#111110011011, 2#110011010110, 2#100110001101,
2#111100000000, 2#101101010001, 2#011100101110, 2#100011101110, 2#111100010010, 2#010111111010,
2#100000101000, 2#011001111001, 2#100001010100, 2#100111011101, 2#001101100011, 2#001001110100,
2#101011010100, 2#001101111000, 2#101111010010, 2#110001000111, 2#100001000101, 2#100110110011,
2#000011101100, 2#111000000000, 2#010110000011, 2#011001000111, 2#010101100101, 2#110100100010,
2#111100100100, 2#010011011101, 2#101100100110, 2#011111111001, 2#101100111001, 2#000000110110,
2#011111110110, 2#000110110101, 2#111111010110, 2#111000111001, 2#111111100001, 2#010000111111,
2#000100000111, 2#010101001110, 2#011001011101, 2#110111100101, 2#100011001001, 2#110100101101,
2#110110010111, 2#101001010111, 2#011011010011, 2#100100000000, 2#111001101000, 2#001101010101,
2#000100010100, 2#100001101000, 2#011001101110, 2#100111100111, 2#011001111110, 2#101011111111,
2#100111100001, 2#000001011110, 2#010110100011, 2#100100010110, 2#001010011110, 2#101101111001,
2#000100111100, 2#101011011011, 2#011010000111, 2#001011011001, 2#001110110000, 2#110001001011,
2#011100010110, 2#111011110101, 2#110100000110, 2#101001011100, 2#010010001000, 2#111001110101,
2#000111000011, 2#110111010110, 2#011111111010, 2#101000011111, 2#111001100101, 2#011100000000,
2#010101010111, 2#100111111011, 2#110100001111, 2#010111011101, 2#011000100010, 2#111111000110,
2#111011100110, 2#100010111100, 2#110100111000, 2#100001010101, 2#101101100011, 2#011001001101,
2#011011111000, 2#000011111010, 2#011010110001, 2#001000110010, 2#011000111110, 2#010101110011,
2#101011110100, 2#100011011011, 2#111010000010, 2#011010101000, 2#101110111111, 2#011110111011,
2#011101101111, 2#110010011001, 2#010001100011, 2#001101010011, 2#100001001010, 2#110110110111,
2#010010100000, 2#100110000100, 2#110110101110, 2#100101101001, 2#110101001111, 2#011101110110,
2#010111111001, 2#000010101110, 2#000000001000, 2#111110000000, 2#100010010011, 2#011100011101,
2#100100001000, 2#101001000111, 2#011000001111, 2#100111111001, 2#000001000011, 2#000111100101,
2#111001010001, 2#110011011010, 2#101000100111, 2#111101100010, 2#110100001011, 2#111111001101,
2#001001001001, 2#010110010110, 2#001111010101, 2#011010010100, 2#001110001000, 2#000011110010,
2#010111111100, 2#101101001011, 2#011001111111, 2#000110110111, 2#101001001110, 2#100000011101,
2#100100110111, 2#111001110110, 2#100110011001, 2#001010000101, 2#111011000110, 2#110010010101,
2#000110000001, 2#111111010111, 2#100100100000, 2#000110011111, 2#000111110011, 2#100100101001,
2#100100001100, 2#110010001110, 2#010100001010, 2#101001000010, 2#001100000000, 2#001011111001,
2#011100001001, 2#010010000101, 2#110101100111, 2#101110111100, 2#111011000001, 2#000111010111,
2#010000000100, 2#101101001100, 2#101010001100, 2#000101011010, 2#110011101011, 2#110101010001,
2#000010111000, 2#101010011111, 2#010011011010, 2#011011001000, 2#010100110101, 2#010111100111,
2#011011000111, 2#100001110011, 2#101000000010, 2#000110010000, 2#101011101011, 2#010000010100,
2#011100000100, 2#001010111010, 2#011111001001, 2#000101110101, 2#100001001100, 2#111000011101,
2#001101101110, 2#010100011110, 2#100101111100, 2#000010100000, 2#111100001001, 2#001110000010,
2#100000100110, 2#011000001011, 2#110110110101, 2#001100000101, 2#000001100110, 2#000001010111,
2#110101011101, 2#001010010101, 2#110011101100, 2#110101110010, 2#000101100010, 2#111000100000,
2#001110111001, 2#010100110100, 2#101000100010, 2#011110100101, 2#011110000111, 2#000011000111,
2#101101101001, 2#000011001001, 2#000111011010, 2#000110001000, 2#011100101011, 2#100110110110,
2#001110100011, 2#001110100101, 2#111011101110, 2#100110110111, 2#111000000110, 2#001110001111,
2#011001101011, 2#111000110100, 2#000101110111, 2#001001001111, 2#010111101010, 2#100010101110,
2#111001100000, 2#111111000000, 2#111010101111, 2#010010010010, 2#110011010111, 2#000001101010,
2#101101111110, 2#100011000111, 2#100111001110, 2#011110111010, 2#001101000101, 2#100000001101,
2#011001110000, 2#001011100001, 2#011101000000, 2#100010010101, 2#111111011111, 2#000001110001,
2#001110010010, 2#111000110011, 2#010001011011, 2#100011010010, 2#001110011101, 2#000100001010,
2#111000001000, 2#001001111011, 2#010000111000, 2#010111000010, 2#110010000011, 2#001111001100,
2#001100101001, 2#011010110010, 2#001010001111, 2#100010100011, 2#100110111111, 2#000101110110,
2#010100000001, 2#110010011110, 2#100000111001, 2#011101100000, 2#001010110101, 2#101101011111,
2#010101111010, 2#110101011111, 2#100110111110, 2#011101010100, 2#110101001010, 2#010100110111,
2#101100000101, 2#100000100010, 2#000011100110, 2#010000010011, 2#000010101101, 2#101001111011,
2#000100110100, 2#001110110001, 2#100010101100, 2#111010001011, 2#000000101110, 2#111101000100,
2#000011011110, 2#100010001000, 2#001101101010, 2#101100100100, 2#000101001111, 2#101000101111,
2#001110101001, 2#001101010100, 2#000011000010, 2#001001100000, 2#111101010010, 2#000001101001,
2#010011110000, 2#000100110000, 2#010000101011, 2#011110011111, 2#110011100011, 2#010000110011,
2#110101111000, 2#101000001010, 2#110101100101, 2#010110100010, 2#101001000110, 2#101101111100,
2#011001011000, 2#100011101011, 2#110111111110, 2#111000111110, 2#110010001111, 2#101010100011,
2#001100100111, 2#001111100111, 2#101101001111, 2#100111011110, 2#101010101100, 2#000100010010,
2#111011110001, 2#101111111101, 2#000001000010, 2#101010110110, 2#001100001010, 2#001111011111,
2#110110111111, 2#100110010111, 2#001011001011, 2#000011001101, 2#011000110011, 2#000100101111,
2#100111010100, 2#011000011011, 2#000010101010, 2#010111110111, 2#000100011001, 2#110110001100,
2#100010011100, 2#111110000001, 2#101110011100, 2#111011110100, 2#001101100101, 2#000110001111,
2#001101110111, 2#000010101001, 2#111010101000, 2#010000001001, 2#100100011001, 2#100001011000,
2#011110110000, 2#000001010110, 2#101000001000, 2#001100011110, 2#110010100001, 2#000011100001,
2#111111001110, 2#011110011110, 2#100110111100, 2#100001011100, 2#100011011010, 2#011000011110,
2#110011000101, 2#001100011100, 2#011110010010, 2#110000101110, 2#010011100111, 2#010111010110,
2#111010011001, 2#110000011010, 2#000101101000, 2#010111001100, 2#001000010011, 2#001110101110,
2#000101101001, 2#110111101001, 2#111101011000, 2#000011110111, 2#011010101100, 2#110110110110,
2#000011011100, 2#111110001111, 2#100110100001, 2#110100010111, 2#101001111000, 2#001111000011,
2#110111011010, 2#101001100001, 2#001001010001, 2#011010101010, 2#111010100010, 2#010011100010,
2#111011011010, 2#001000000110, 2#011111010010, 2#100000010000, 2#000001110011, 2#001010111100,
2#110000110110, 2#110011001010, 2#001011001100, 2#100010100001, 2#100110010000, 2#100100011011,
2#100111001100, 2#100101001001, 2#000100101101, 2#101000101000, 2#010011100001, 2#111101101000,
2#011010010001, 2#100100110110, 2#110001011101, 2#011001111010, 2#100101000000, 2#011110100000,
2#001000001100, 2#111000101010, 2#001011000010, 2#110000101100, 2#110011011000, 2#011010100101,
2#100111001011, 2#110110111100, 2#100101101000, 2#000010111100, 2#010010010101, 2#100110101100,
2#010101101111, 2#101100111111, 2#001111111011, 2#100000111101, 2#010010111100, 2#001011110000,
2#111010011000, 2#000101111110, 2#011011111011, 2#000001101011, 2#000111111000, 2#000111010001,
2#000111110010, 2#100000111111, 2#110100101100, 2#001010100100, 2#001111011010, 2#111011010010,
2#111111000011, 2#001000101111, 2#000000000010, 2#111011100010, 2#111000110000, 2#000000110010,
2#111110111011, 2#000110100111, 2#101000000011, 2#011101100011, 2#001010000011, 2#011001111101,
2#000101011101, 2#101101110010, 2#011011101101, 2#101011110001, 2#110110010110, 2#101110111000,
2#111010110111, 2#001001111100, 2#100101011110, 2#101000010100, 2#101000110010, 2#001110110111,
2#000001000111, 2#100101000001, 2#011111011100, 2#101010001000, 2#001101010000, 2#110101001000,
2#001010010011, 2#101001011000, 2#111101010001, 2#100000110100, 2#110101000011, 2#000011101111,
2#001011000101, 2#110100101011, 2#010000011000, 2#100011001101, 2#101010001111, 2#001011101011,
2#011110010001, 2#011010001101, 2#111110011001, 2#110110001111, 2#100100111011, 2#110001110011,
2#110000100001, 2#010010010000, 2#011111010011, 2#101100111011, 2#010111100110, 2#111000101001,
2#000000110001, 2#000010001110, 2#010110101111, 2#001100001100, 2#101011011001, 2#000010001010,
2#101100100111, 2#011011101010, 2#111011010001, 2#001011101010, 2#110011111011, 2#011101000101,
2#101101100100, 2#101100111010, 2#100001000100, 2#111001111111, 2#110001000011, 2#000101110000,
2#100101000010, 2#000000000100, 2#110001000000, 2#110111010001, 2#010011101010, 2#010101110001,
2#111101110011, 2#000000101011, 2#011011111101, 2#100101110010, 2#110000111101, 2#000110111101,
2#100011000100, 2#011011111100, 2#101110101011, 2#110100110101, 2#110001001010, 2#010111001111,
2#010011100101, 2#011010011111, 2#011000011111, 2#110000010000, 2#011000001010, 2#111111001010,
2#010001000011, 2#110110000110, 2#110110111000, 2#010110011011, 2#100000101110, 2#101111100100,
2#110011100100, 2#011010111000, 2#011001001111, 2#101000100000, 2#001010001000, 2#001000101011,
2#111101111100, 2#111110100000, 2#001111111010, 2#000000111101, 2#100011100010, 2#000101101101,
2#011111000111, 2#010010001001, 2#000001110100, 2#010000010010, 2#101110011111, 2#001010000001,
2#011100010111, 2#111001111000, 2#001100101011, 2#100111101101, 2#111011011100, 2#100001101110,
2#100100010010, 2#000110111111, 2#010011101100, 2#110001100100, 2#011010111100, 2#000000101100,
2#001011110110, 2#011101100001, 2#000100111101, 2#111011111111, 2#000101100011, 2#101011001011,
2#110110101001, 2#000001100101, 2#010111100001, 2#110001001101, 2#011000000000, 2#101100001110,
2#101101011101, 2#100011110110, 2#100101000100, 2#001001011100, 2#100101100000, 2#010000101010,
2#001001101100, 2#011111110010, 2#110101101000, 2#100000100101, 2#011111010100, 2#111110000100,
2#000010110001, 2#110110110001, 2#001001100010, 2#101000001110, 2#101111010011, 2#101101100010,
2#011110100110, 2#011100100010, 2#000001110110, 2#111010010100, 2#111111111110, 2#111010100101,
2#100100110001, 2#000100001001, 2#100010111110, 2#001111000000, 2#110110111110, 2#100111110101,
2#110000110000, 2#001000101100, 2#011111000110, 2#011000110100, 2#111010100111, 2#010101000010,
2#110111100011, 2#011111111000, 2#100111000101, 2#000010011111, 2#101010100100, 2#111001010011,
2#101111101101, 2#000111011110, 2#100110001011, 2#110101010111, 2#000010010000, 2#100111101110,
2#111101011100, 2#001000101010, 2#001011001001, 2#011010100000, 2#001100010100, 2#110111000001,
2#100100011100, 2#110111000100, 2#011001011011, 2#111000010100, 2#101110100000, 2#100000010001,
2#100000001001, 2#001010000110, 2#100011011110, 2#100111011011, 2#100110110100, 2#111000110010,
2#000001001011, 2#111001110111, 2#011101000010, 2#010101100110, 2#101011110011, 2#111100011110,
2#111100011101, 2#101110011110, 2#101010001101, 2#111100000110, 2#000111111111, 2#001010101101,
2#011101000011, 2#100000001110, 2#110101101100, 2#000100110001, 2#111101101001, 2#101010001001,
2#001101011010, 2#011000000101, 2#011101101001, 2#011000100001, 2#100101010100, 2#011000101100,
2#010110110010, 2#000010011011, 2#110101001011, 2#101001111001, 2#101000101001, 2#011001100010,
2#100010001011, 2#001100100110, 2#100000111011, 2#001111100001, 2#101110001101, 2#101010000010,
2#110010101100, 2#100100000100, 2#011001111011, 2#101000010001, 2#110101101101, 2#101000000001,
2#101111101000, 2#011001110110, 2#111101010110, 2#110001011111, 2#110111110111, 2#010010110100,
2#111111100000, 2#110100011010, 2#000110100011, 2#010001111010, 2#010111100101, 2#000001110000,
2#011110000110, 2#101010111010, 2#001000010111, 2#000001000101, 2#010101001010, 2#011111010000,
2#000011100011, 2#100011101010, 2#111011011001, 2#111111100101, 2#010000101101, 2#011110010111,
2#110100101010, 2#000110101111, 2#110101010011, 2#101110000010, 2#110101011001, 2#110110111101,
2#010101110100, 2#101001101011, 2#101100000111, 2#010001111110, 2#101110001110, 2#011011110001,
2#010111000101, 2#001010111000, 2#001010000111, 2#001111001110, 2#100010011110, 2#100000110010,
2#100000011111, 2#001000100010, 2#010111001110, 2#011110011100, 2#010001101101, 2#101011001001,
2#000001001001, 2#100110011000, 2#000001111010, 2#110010101110, 2#101101001000, 2#001011100110,
2#000101001011, 2#110100010101, 2#110101000010, 2#110010111101, 2#011110001111, 2#000011010001,
2#010000111101, 2#011110001110, 2#110110111001, 2#101111111011, 2#101011111110, 2#110001111101,
2#011010010110, 2#111011011111, 2#110100100001, 2#100110101110, 2#101010011000, 2#100001001101,
2#101001110000, 2#001100111001, 2#100001111011, 2#111101110001 ];
		oxigen_input, co2_input : ARRAY[0..len] OF DINT;
		oxigen_val, co2_val : DINT := 0;
		bit : BOOL;
	END_VAR
	VAR_TEMP
		ones, zeros : DINT := 0;
		i,j : DINT := 0;
	END_VAR

	FOR i := 0 TO len -1 DO 
		oxigen_input[i] := input[i];
		co2_input[i] := input[i];
	END_FOR

	FOR j := bit_size - 1 TO 0 BY -1 DO
		zeros := 0;
		ones := 0;
		FOR i := 0 TO len -1 DO
			//Oxigen filter
			IF oxigen_input[i] > -1 THEN
				bit := oxigen_input[i].%Xj;
				IF bit THEN
					ones := ones + 1;
				ELSE
					zeros := zeros + 1;
				END_IF
			END_IF
		END_FOR
		FOR i := 0 TO len -1 DO
			IF count(&oxigen_input) = 1 THEN
				EXIT;
			END_IF
			bit := oxigen_input[i].%Xj;
			IF ones >= zeros THEN
				IF NOT bit THEN
					oxigen_input[i] := -1;
				END_IF
			ELSE 
				IF bit THEN
					oxigen_input[i] := -1;
				END_IF
			END_IF
		END_FOR
		zeros := 0;
		ones := 0;
		FOR i := 0 TO len -1 DO
			//co2 filter
			IF co2_input[i] > -1 THEN
				bit := co2_input[i].%Xj;
				IF bit THEN
					ones := ones + 1;
				ELSE
					zeros := zeros + 1;
				END_IF
			END_IF
		END_FOR
		printf('j: %d, ones: %d, zeros: %d$n', j, ones, zeros);
		FOR i := 0 TO len -1 DO
			IF count(&co2_input) = 1 THEN
				EXIT;
			END_IF
			bit := co2_input[i].%Xj;
			IF zeros > ones THEN
				IF NOT bit THEN
					printf('$t line 52: setting co2[%d] : %d to -1$n', i, co2_input[i]);
					co2_input[i] := -1;
				END_IF
			ELSE 
				IF bit THEN
					printf('$t line 57: setting co2[%d] : %d to -1$n', i, co2_input[i]);
					co2_input[i] := -1;
				END_IF
			END_IF
		END_FOR
	END_FOR
	FOR i := 0 TO len - 1 DO
		IF oxigen_input[i] > -1 THEN
			oxigen_val := oxigen_input[i];
		END_IF
		IF co2_input[i] > -1 THEN
			co2_val := co2_input[i];
		END_IF
	END_FOR
	
	printf('oxigen: %d, co2: %d, product %d$n', oxigen_val,co2_val, oxigen_val * co2_val);



END_FUNCTION

FUNCTION count : DINT
VAR_INPUT
	input : REF_TO ARRAY[0..len-1] OF DINT;
END_VAR
VAR_TEMP
	i : DINT := 0;
END_VAR
	count := 0;
	FOR i := 0 TO len - 1 DO
		IF input^[i]  > -1 THEN
			count := count + 1;
		END_IF
	END_FOR
END_FUNCTION