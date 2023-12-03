use std::collections::HashSet;

pub fn run() {
    let input = std::include_str!("day3/input.txt");
    println!("Running Day 3");
    println!("-----------------");
    println!("Part 1 : {}", part1(input));
    println!("-----------------");
    println!("Part 2: {}", part2(input));
    println!("-----------------");
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
enum Entry {
    Part(usize, usize, bool), //Number, len, active
    Symbol(char),
    None,
}

fn part1(input: &str) -> usize {
    let quadrants: [(i32, i32); 9] = [
        // (x-1, y-1)
        (-1, -1),
        // (x, y-1)
        (0, -1),
        // (x+1, y-1)
        (1, -1),
        //(x-1, y)
        (-1, 0),
        //(x,y)
        (0, 0),
        // (x+1,y)
        (1, 0),
        //(x-1, y+1)
        (-1, 1),
        //(x, y+1)
        (0, 1),
        //(x+1, y+1)
        (1, 1),
    ];
    let positions: Vec<Vec<Entry>> = parse_input(input);
    let mut res = 0;
    for (y, line) in positions.iter().enumerate() {
        for (x, entry) in line.iter().enumerate() {
            //See if this position is a number
            if let Entry::Part(num, len, true) = *entry {
                //See if this position is adjacent to a symbol
                if (0..len)
                    .map(|it| x - it)
                    .map(|it| it as i32)
                    .flat_map(|it| {
                        quadrants
                            .iter()
                            .map(move |(x1, y1)| (*x1 + it, *y1 + y as i32))
                    })
                    .any(|(x, y)| {
                        if (x >= 0 && x < line.len() as i32)
                            && (y >= 0 && y < positions.len() as i32)
                        {
                            let line = &positions[y as usize];
                            let entry = line[x as usize];
                            matches!(entry, Entry::Symbol(_))
                        } else {
                            false
                        }
                    })
                {
                    res += num;
                }
            }
        }
    }
    res
}

fn part2(input: &str) -> i32 {
    let top: [(i32, i32); 3] = [
        // (x-1, y-1)
        (-1, -1),
        // (x, y-1)
        (0, -1),
        // (x+1, y-1)
        (1, -1),
    ];
    let bottom: [(i32, i32); 3] = [
        //(x-1, y+1)
        (-1, 1),
        //(x, y+1)
        (0, 1),
        //(x+1, y+1)
        (1, 1),
    ];
    let left: [(i32, i32); 1] = [
        //(x-1, y)
        (-1, 0),
    ];
    let right: [(i32, i32); 1] = [
        // (x+1,y)
        (1, 0),
    ];
    let positions: Vec<Vec<Entry>> = parse_input(input);
    let mut sum = 0;
    for (y, line) in positions.iter().enumerate() {
        for (x, entry) in line.iter().enumerate() {
            if let Entry::Symbol('*') = entry {
                let mut entries = vec![];
                let mut top_entries = HashSet::new();
                for (x, y) in top
                    .iter()
                    .map(|(x1, y1)| ((x as i32) + *x1, (y as i32) + *y1))
                {
                    if let Entry::Part(num, _, _) = positions[y as usize][x as usize] {
                        // dbg!(x, y, num);
                        top_entries.insert(num);
                    }
                }
                // dbg!(&top_entries);
                if !top_entries.is_empty() {
                    for entry in top_entries.drain() {
                        entries.push(entry);
                    }
                }
                let mut bottom_entries = HashSet::new();
                for (x, y) in bottom
                    .iter()
                    .map(|(x1, y1)| ((x as i32) + *x1, (y as i32) + *y1))
                {
                    if let Entry::Part(num, _, _) = positions[y as usize][x as usize] {
                        bottom_entries.insert(num);
                    }
                }
                // dbg!(&bottom_entries);
                if !bottom_entries.is_empty() {
                    for entry in bottom_entries.drain() {
                        entries.push(entry);
                    }
                }
                for (x, y) in left
                    .iter()
                    .map(|(x1, y1)| ((x as i32) + *x1, (y as i32) + *y1))
                {
                    if let Entry::Part(num, _, _) = positions[y as usize][x as usize] {
                        // dbg!(x, y, num);
                        entries.push(num);
                        break;
                    }
                }
                for (x, y) in right
                    .iter()
                    .map(|(x1, y1)| ((x as i32) + *x1, (y as i32) + *y1))
                {
                    if let Entry::Part(num, _, _) = positions[y as usize][x as usize] {
                        // dbg!(x, y, num);
                        entries.push(num);
                        break;
                    }
                }
                if entries.len() > 1 {
                    // dbg!(&entries);
                    sum += entries.iter().product::<usize>();
                }
            }
        }
    }
    sum as i32
}

fn parse_input(input: &str) -> Vec<Vec<Entry>> {
    let mut res = vec![];
    for line in input.lines().filter(|it| !it.trim().is_empty()) {
        let mut current = vec![];
        let mut current_num: Option<String> = None;
        for (x, c) in line.char_indices() {
            if c == '.' {
                if let Some(num) = &current_num {
                    let num_len = num.len();
                    let num = num.parse().expect("Expecting int");
                    for i in 1..num_len {
                        current[x - i - 1] = Entry::Part(num, num_len, false);
                    }
                    current[x - 1] = Entry::Part(num, num_len, true);
                    current_num = None;
                }
                current.push(Entry::None);
            } else if c.is_numeric() {
                current_num.get_or_insert(String::new()).push(c);
                current.push(Entry::None);
            } else {
                if let Some(num) = &current_num {
                    let num_len = num.len();
                    let num = num.parse().expect("Expecting int");
                    for i in 1..num_len {
                        current[x - i - 1] = Entry::Part(num, num_len, false);
                    }
                    current[x - 1] = Entry::Part(num, num_len, true);
                    current_num = None;
                }
                current.push(Entry::Symbol(c));
            }
            //If at line end, also flush it
            if x == line.len() - 1 {
                if let Some(num) = &current_num {
                    let num_len = num.len();
                    let num = num.parse().expect("Expecting int");
                    for i in 1..num_len {
                        current[x - i] = Entry::Part(num, num_len, false);
                    }
                    current[x] = Entry::Part(num, num_len, true);
                    current_num = None;
                }
            }
        }
        res.push(current);
    }
    res
}

#[test]
fn test_part1() {
    let input = r"
467..114..
...*......
..35...633
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
";
    assert_eq!(part1(input), 4361)
}

#[test]
fn test_part2() {
    let input = r"
467..114..
...*......
..35...633
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
";
    assert_eq!(part2(input), 467835)
}
