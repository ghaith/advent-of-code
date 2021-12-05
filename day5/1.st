@EXTERNAL
FUNCTION printf : DINT
VAR_INPUT
	str : STRING[1024];
	params : ...;
END_VAR
END_FUNCTION

TYPE point : STRUCT x,y : DINT; END_STRUCT END_TYPE
TYPE line : STRUCT start,end : point; END_STRUCT END_TYPE

VAR_GLOBAL CONSTANT
	len : DINT := 500;
	grid_max : DINT := 1000;
	/* len : DINT := 10; */
	/* grid_max : DINT := 10; */
END_VAR

FUNCTION main : DINT
VAR_TEMP
	// .           x   y
	grid : ARRAY[0..grid_max-1,0..grid_max-1] OF DINT := [10000(0)];
	lines : ARRAY[0..len-1] OF line;
	i,j : DINT := 0;
	overlaps : DINT := 0;
END_VAR
	add.current := 0;
	/* add(&lines,0,9,5,9); */
	/* add(&lines,8,0,0,8); */
	/* add(&lines,9,4,3,4); */
	/* add(&lines,2,2,2,1); */
	/* add(&lines,7,0,7,4); */
	/* add(&lines,6,4,2,0); */
	/* add(&lines,0,9,2,9); */
	/* add(&lines,3,4,1,4); */
	/* add(&lines,0,0,8,8); */
	/* add(&lines,5,5,8,2); */
	set_input(&lines);

	fill_grid(&grid, &lines);

	FOR j := 0 TO grid_max-1 DO //y
		FOR i := 0 TO grid_max-1 DO //x
			IF grid[i,j] > 1 THEN
				overlaps := overlaps + 1;
			END_IF
		END_FOR
	END_FOR
	printf('Overlapping areas : %d$N', overlaps);
END_FUNCTION

FUNCTION fill_grid : DINT
VAR_INPUT
	// .                  x   y
	grid : REF_TO ARRAY[0..grid_max-1,0..grid_max-1] OF DINT; 
	lines : REF_TO ARRAY[0..len - 1] OF line;
END_VAR
VAR_TEMP
	i,j,k : DINT := 0;
	stepj,stepk : DINT := 1;
	current : line;
END_VAR
	//Clear the grid
	FOR j := 0 TO grid_max-1 DO //y
		FOR i := 0 TO grid_max-1 DO //x
			grid^[i,j] := 0;
		END_FOR
	END_FOR

	FOR i := 0 TO len - 1 DO
		current := lines^[i];
		//Only consider horizontal/vertical lines
		IF current.start.x = current.end.x OR current.start.y = current.end.y THEN
			stepj := direction(current.start.x, current.end.x); 
			stepk := direction(current.start.y, current.end.y); 
			FOR k := current.start.y TO current.end.y BY stepk DO //y
				FOR j := current.start.x TO current.end.x BY stepj DO  //x
					grid^[j,k] := grid^[j,k] + 1;
				END_FOR
			END_FOR
		END_IF
	END_FOR
END_FUNCTION


FUNCTION direction : DINT 
VAR_INPUT
	start,end : DINT;
END_VAR
	direction := 1;
	IF start > end THEN
		direction := -1;
	END_IF
END_FUNCTION

PROGRAM add 
VAR_INPUT
	arr : REF_TO ARRAY[0..len-1] OF line;
	x1,y1 : DINT;
	x2,y2 : DINT;
END_VAR
VAR
	current  : DINT := 0;
END_VAR
	arr^[current].start.x := x1;
	arr^[current].start.y := y1;
	arr^[current].end.x := x2;
	arr^[current].end.y := y2;

	current := current + 1;
END_PROGRAM

FUNCTION set_input : DINT
VAR_INPUT
	lines : REF_TO ARRAY[0..len-1] OF line;
END_VAR
add(lines,694,732,290,328);
add(lines,872,938,167,233);
add(lines,770,318,770,437);
add(lines,974,980,28,34);
add(lines,25,739,431,333);
add(lines,132,311,132,89);
add(lines,926,479,926,37);
add(lines,239,395,239,722);
add(lines,286,538,713,538);
add(lines,216,945,570,945);
add(lines,975,858,854,858);
add(lines,846,437,313,437);
add(lines,90,318,90,151);
add(lines,748,429,976,429);
add(lines,750,500,750,951);
add(lines,935,922,38,25);
add(lines,543,914,359,914);
add(lines,339,820,339,78);
add(lines,978,358,978,245);
add(lines,975,976,22,23);
add(lines,767,159,180,159);
add(lines,583,956,583,48);
add(lines,208,267,208,765);
add(lines,848,906,848,895);
add(lines,325,374,587,374);
add(lines,257,936,257,777);
add(lines,276,179,579,179);
add(lines,179,134,390,134);
add(lines,381,286,381,190);
add(lines,931,220,931,540);
add(lines,957,774,305,774);
add(lines,610,682,965,682);
add(lines,640,672,344,376);
add(lines,241,795,241,908);
add(lines,638,641,646,633);
add(lines,919,860,114,55);
add(lines,833,163,18,978);
add(lines,73,51,987,965);
add(lines,702,909,750,909);
add(lines,579,473,579,582);
add(lines,455,475,455,498);
add(lines,77,100,956,979);
add(lines,376,424,376,361);
add(lines,923,802,923,89);
add(lines,343,451,648,756);
add(lines,554,57,614,57);
add(lines,977,949,977,115);
add(lines,249,109,249,143);
add(lines,930,66,933,69);
add(lines,654,948,810,948);
add(lines,544,424,296,424);
add(lines,716,52,10,758);
add(lines,960,557,899,557);
add(lines,379,293,417,331);
add(lines,620,287,508,399);
add(lines,518,961,518,948);
add(lines,961,433,702,433);
add(lines,735,166,772,166);
add(lines,587,31,715,31);
add(lines,705,55,680,55);
add(lines,122,656,578,656);
add(lines,576,25,576,721);
add(lines,434,791,434,177);
add(lines,588,979,588,133);
add(lines,54,545,54,236);
add(lines,949,14,95,14);
add(lines,17,533,17,316);
add(lines,218,443,973,443);
add(lines,281,443,281,797);
add(lines,237,847,237,400);
add(lines,543,776,309,542);
add(lines,600,267,600,452);
add(lines,856,93,856,95);
add(lines,724,43,724,216);
add(lines,616,793,616,488);
add(lines,549,794,549,486);
add(lines,830,858,39,67);
add(lines,623,545,477,399);
add(lines,695,42,71,666);
add(lines,709,951,709,310);
add(lines,755,354,755,341);
add(lines,162,86,162,868);
add(lines,563,809,987,809);
add(lines,573,838,573,141);
add(lines,204,85,204,453);
add(lines,96,304,574,782);
add(lines,702,693,681,672);
add(lines,917,628,917,654);
add(lines,503,228,118,228);
add(lines,911,202,983,202);
add(lines,195,373,131,373);
add(lines,978,905,426,905);
add(lines,527,585,527,561);
add(lines,241,520,241,812);
add(lines,301,501,576,226);
add(lines,982,169,220,169);
add(lines,839,105,768,105);
add(lines,898,387,399,886);
add(lines,241,805,296,805);
add(lines,555,526,314,526);
add(lines,723,235,56,235);
add(lines,565,900,119,454);
add(lines,100,255,755,255);
add(lines,985,982,66,63);
add(lines,968,50,255,50);
add(lines,676,39,676,513);
add(lines,181,306,438,49);
add(lines,958,333,280,333);
add(lines,732,309,845,309);
add(lines,604,457,644,417);
add(lines,736,61,515,61);
add(lines,553,60,445,168);
add(lines,767,475,771,471);
add(lines,813,110,39,884);
add(lines,82,177,457,177);
add(lines,266,64,807,64);
add(lines,135,37,924,826);
add(lines,449,595,167,877);
add(lines,13,32,964,983);
add(lines,156,932,765,932);
add(lines,738,588,738,522);
add(lines,130,26,130,464);
add(lines,681,485,986,180);
add(lines,463,93,349,93);
add(lines,364,324,364,376);
add(lines,858,228,858,749);
add(lines,271,536,224,583);
add(lines,80,953,940,93);
add(lines,977,293,977,985);
add(lines,417,256,690,256);
add(lines,973,874,150,51);
add(lines,562,34,116,34);
add(lines,10,837,10,43);
add(lines,500,500,983,17);
add(lines,480,444,807,444);
add(lines,150,842,419,842);
add(lines,28,866,684,210);
add(lines,791,750,772,769);
add(lines,673,13,673,777);
add(lines,842,693,332,693);
add(lines,934,985,15,66);
add(lines,102,165,796,165);
add(lines,386,768,386,863);
add(lines,807,174,459,174);
add(lines,388,397,388,120);
add(lines,313,360,590,83);
add(lines,546,364,28,364);
add(lines,36,50,747,761);
add(lines,587,597,526,597);
add(lines,133,16,836,16);
add(lines,867,375,725,233);
add(lines,875,296,875,520);
add(lines,77,60,614,60);
add(lines,702,654,395,961);
add(lines,50,963,982,31);
add(lines,30,110,841,921);
add(lines,277,401,397,281);
add(lines,125,962,977,110);
add(lines,592,895,837,895);
add(lines,904,159,578,485);
add(lines,146,158,146,253);
add(lines,901,201,901,792);
add(lines,707,847,707,936);
add(lines,354,709,928,709);
add(lines,415,338,610,143);
add(lines,686,669,686,92);
add(lines,915,143,609,449);
add(lines,938,862,976,862);
add(lines,52,763,342,763);
add(lines,141,840,141,826);
add(lines,360,223,834,697);
add(lines,821,989,359,989);
add(lines,925,854,925,249);
add(lines,287,48,287,453);
add(lines,543,986,369,986);
add(lines,576,886,522,886);
add(lines,819,441,819,629);
add(lines,432,661,432,871);
add(lines,366,841,356,841);
add(lines,786,104,786,549);
add(lines,576,15,42,549);
add(lines,757,135,231,661);
add(lines,569,210,197,582);
add(lines,378,32,378,988);
add(lines,829,822,195,188);
add(lines,461,457,339,335);
add(lines,608,742,608,288);
add(lines,582,650,182,650);
add(lines,713,554,713,581);
add(lines,702,919,702,829);
add(lines,956,960,406,410);
add(lines,22,461,22,24);
add(lines,333,572,333,225);
add(lines,374,582,374,463);
add(lines,294,736,265,736);
add(lines,29,462,29,271);
add(lines,858,80,192,746);
add(lines,419,186,419,625);
add(lines,518,320,244,46);
add(lines,523,971,745,971);
add(lines,83,78,657,78);
add(lines,583,868,583,58);
add(lines,287,830,709,830);
add(lines,162,691,495,358);
add(lines,704,28,704,846);
add(lines,350,278,912,278);
add(lines,496,15,454,15);
add(lines,139,967,715,391);
add(lines,792,440,947,440);
add(lines,77,773,31,727);
add(lines,734,413,835,514);
add(lines,124,342,124,785);
add(lines,747,397,988,638);
add(lines,542,158,675,158);
add(lines,169,969,910,228);
add(lines,856,865,856,193);
add(lines,960,63,58,965);
add(lines,14,13,969,968);
add(lines,26,754,750,30);
add(lines,402,297,131,26);
add(lines,182,567,446,567);
add(lines,944,891,428,375);
add(lines,587,900,474,900);
add(lines,274,533,317,490);
add(lines,529,43,606,120);
add(lines,644,584,644,558);
add(lines,706,824,348,466);
add(lines,700,416,401,416);
add(lines,986,829,217,60);
add(lines,241,383,863,383);
add(lines,877,833,866,833);
add(lines,376,423,856,903);
add(lines,234,926,185,975);
add(lines,747,441,747,988);
add(lines,99,739,99,49);
add(lines,763,554,763,693);
add(lines,168,78,168,594);
add(lines,81,922,946,57);
add(lines,685,344,42,344);
add(lines,39,656,283,412);
add(lines,502,709,158,365);
add(lines,143,423,924,423);
add(lines,876,846,107,77);
add(lines,356,120,356,785);
add(lines,485,91,404,91);
add(lines,976,403,976,575);
add(lines,371,390,371,851);
add(lines,380,206,380,228);
add(lines,232,268,232,338);
add(lines,150,48,246,144);
add(lines,977,970,25,18);
add(lines,50,205,691,205);
add(lines,41,898,41,97);
add(lines,181,512,46,512);
add(lines,675,15,837,177);
add(lines,687,317,687,362);
add(lines,191,922,745,922);
add(lines,209,136,561,136);
add(lines,708,919,133,344);
add(lines,54,148,769,148);
add(lines,68,199,210,199);
add(lines,959,282,959,334);
add(lines,842,362,641,362);
add(lines,392,712,572,712);
add(lines,798,874,74,150);
add(lines,107,482,470,119);
add(lines,71,24,815,768);
add(lines,216,35,922,741);
add(lines,185,497,160,522);
add(lines,585,246,676,155);
add(lines,762,657,762,871);
add(lines,85,441,85,156);
add(lines,248,276,346,178);
add(lines,291,917,747,917);
add(lines,54,958,989,23);
add(lines,864,591,443,170);
add(lines,544,667,268,667);
add(lines,819,184,200,803);
add(lines,418,191,493,116);
add(lines,553,741,462,741);
add(lines,266,155,707,596);
add(lines,571,308,895,308);
add(lines,77,611,641,47);
add(lines,210,595,210,356);
add(lines,718,711,79,72);
add(lines,816,310,142,984);
add(lines,936,974,141,179);
add(lines,287,888,927,888);
add(lines,859,70,859,128);
add(lines,34,604,34,961);
add(lines,916,446,183,446);
add(lines,471,615,231,855);
add(lines,88,514,88,616);
add(lines,183,301,313,301);
add(lines,982,41,185,838);
add(lines,62,607,13,607);
add(lines,853,688,399,234);
add(lines,487,152,487,682);
add(lines,282,50,312,50);
add(lines,448,285,789,626);
add(lines,362,875,362,293);
add(lines,795,940,795,451);
add(lines,743,871,743,19);
add(lines,493,297,493,607);
add(lines,988,615,364,615);
add(lines,657,214,657,500);
add(lines,784,627,805,627);
add(lines,580,269,870,269);
add(lines,966,942,655,942);
add(lines,42,871,880,33);
add(lines,599,385,952,32);
add(lines,31,662,735,662);
add(lines,703,733,703,791);
add(lines,771,866,771,46);
add(lines,902,360,902,258);
add(lines,632,806,887,806);
add(lines,835,307,819,307);
add(lines,166,875,166,12);
add(lines,564,984,564,54);
add(lines,90,411,90,403);
add(lines,86,247,86,329);
add(lines,104,781,464,781);
add(lines,77,663,264,850);
add(lines,223,634,755,634);
add(lines,529,908,529,793);
add(lines,443,22,443,144);
add(lines,159,704,40,704);
add(lines,102,811,102,186);
add(lines,803,266,803,937);
add(lines,569,586,569,954);
add(lines,987,988,12,13);
add(lines,264,288,283,288);
add(lines,927,139,817,139);
add(lines,523,206,523,166);
add(lines,76,333,651,908);
add(lines,40,910,687,263);
add(lines,760,977,117,334);
add(lines,596,344,596,546);
add(lines,852,859,753,760);
add(lines,581,266,802,266);
add(lines,985,603,985,246);
add(lines,631,381,814,381);
add(lines,341,884,341,308);
add(lines,555,255,891,255);
add(lines,82,50,82,561);
add(lines,50,110,344,404);
add(lines,651,518,651,879);
add(lines,86,904,86,157);
add(lines,223,258,908,943);
add(lines,593,507,454,507);
add(lines,941,65,74,932);
add(lines,758,33,758,811);
add(lines,671,816,202,347);
add(lines,857,905,212,260);
add(lines,83,11,83,167);
add(lines,346,531,724,153);
add(lines,245,113,772,640);
add(lines,694,149,694,308);
add(lines,458,482,177,201);
add(lines,305,248,408,351);
add(lines,910,875,56,21);
add(lines,410,303,798,303);
add(lines,352,959,352,224);
add(lines,413,210,875,672);
add(lines,942,47,942,588);
add(lines,839,872,58,91);
add(lines,970,908,140,78);
add(lines,748,256,441,256);
add(lines,478,683,609,683);
add(lines,807,930,950,930);
add(lines,730,804,730,817);
add(lines,960,826,807,979);
add(lines,130,602,142,590);
add(lines,968,860,968,572);
add(lines,240,465,633,72);
add(lines,718,428,718,606);
add(lines,350,904,350,743);
add(lines,198,30,970,802);
add(lines,173,345,173,693);
add(lines,873,254,873,714);
add(lines,244,726,244,830);
add(lines,620,399,147,399);
add(lines,318,929,318,83);
add(lines,837,800,843,800);
add(lines,418,486,865,486);
add(lines,916,53,916,207);
add(lines,127,582,127,952);
add(lines,888,162,941,162);
add(lines,660,965,110,415);
add(lines,981,187,383,785);
add(lines,940,809,940,889);
add(lines,342,479,271,550);
add(lines,646,51,646,340);
add(lines,260,947,906,947);
add(lines,961,928,638,928);
add(lines,988,15,18,985);
add(lines,393,437,460,437);
add(lines,888,91,888,83);
add(lines,875,707,860,722);
add(lines,387,187,895,695);
add(lines,857,561,928,561);
add(lines,15,52,398,52);
add(lines,363,821,324,782);
add(lines,761,535,290,64);
add(lines,878,539,878,317);
add(lines,577,890,51,890);
add(lines,379,471,379,627);
add(lines,65,91,535,91);
add(lines,79,77,897,895);
add(lines,863,324,885,324);
add(lines,970,536,970,879);
add(lines,924,743,765,743);
add(lines,317,524,89,524);
add(lines,585,568,585,229);
add(lines,29,338,179,338);
add(lines,937,925,937,239);
add(lines,478,905,542,905);
add(lines,191,147,191,956);
add(lines,759,101,59,801);
add(lines,131,315,131,121);
add(lines,132,121,805,794);
add(lines,97,430,541,430);
add(lines,887,426,516,426);
add(lines,311,968,261,968);
add(lines,503,628,665,628);
add(lines,277,670,705,670);
add(lines,747,671,836,671);
add(lines,892,55,14,933);
add(lines,973,711,835,573);
add(lines,18,932,300,932);
add(lines,562,923,562,850);
add(lines,416,982,416,742);
add(lines,13,918,870,61);
add(lines,252,313,252,702);
add(lines,340,563,340,636);
add(lines,858,88,858,646);
add(lines,806,963,54,963);
add(lines,674,703,674,760);
add(lines,826,782,826,362);
add(lines,655,558,655,213);
add(lines,716,929,23,929);
add(lines,701,904,701,234);
add(lines,496,17,896,17);
add(lines,577,139,577,117);
add(lines,613,336,925,24);
add(lines,804,726,804,551);
add(lines,301,134,616,134);
add(lines,840,695,301,156);
add(lines,148,280,209,280);
add(lines,531,353,531,666);
add(lines,899,726,899,162);
add(lines,817,23,47,793);
add(lines,673,921,673,15);
add(lines,543,863,543,795);
add(lines,947,464,947,164);
add(lines,54,42,840,828);
add(lines,24,54,24,381);
add(lines,958,293,958,748);
add(lines,674,800,674,909);
add(lines,895,24,343,24);
add(lines,659,513,182,36);
add(lines,754,268,260,762);
add(lines,619,544,619,212);
add(lines,961,607,961,558);
add(lines,390,450,390,796);
add(lines,486,560,486,801);
add(lines,653,44,225,44);
add(lines,662,604,951,315);
add(lines,929,537,429,37);
add(lines,44,958,715,287);
add(lines,205,970,352,970);
add(lines,190,867,914,143);
add(lines,276,789,602,463);
add(lines,239,534,239,457);
add(lines,715,841,695,841);
add(lines,411,864,418,864);
add(lines,612,624,652,624);
add(lines,382,305,382,890);
add(lines,55,59,748,752);
add(lines,984,16,46,954);
add(lines,530,625,530,776);
add(lines,944,67,395,616);
add(lines,561,744,561,79);
add(lines,638,628,502,628);
add(lines,474,556,474,953);
add(lines,786,227,733,227);
add(lines,13,15,977,979);
add(lines,900,137,98,939);
add(lines,604,240,228,616);
add(lines,152,32,474,354);
add(lines,500,982,442,982);
add(lines,989,345,445,345);
add(lines,819,279,819,68);
add(lines,603,266,795,266);
add(lines,486,311,783,311);
add(lines,434,58,568,58);
add(lines,195,75,195,806);
add(lines,39,78,233,78);
add(lines,648,503,648,847);
add(lines,306,867,773,867);
END_FUNCTION
