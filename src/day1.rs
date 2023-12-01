pub fn run() {
    let input = std::include_str!("day1/input.txt");
    println!("{}", part1(input));
    println!("{}", part2(input));
}
fn part1(input: &str) -> u32 {
    input
        .lines()
        .filter(|it| !it.trim().is_empty())
        .map(|it| {
            let first: u32 = it.chars().find_map(|it| it.to_digit(10)).unwrap();
            let last: u32 = it
                .chars()
                .filter_map(|it| it.to_digit(10))
                .next_back()
                .unwrap();
            first * 10 + last
        })
        .sum()
}

fn part2(input: &str) -> u32 {
    input
        .lines()
        .filter(|it| !it.trim().is_empty())
        .map(|it| {
            let mut start = 0;
            let mut output = String::new();
            while start <= it.len() {
                if it[start..].starts_with("one") {
                    output.push('1');
                    // start += 2;
                } else if it[start..].starts_with("two") {
                    output.push('2');
                    // start += 2;
                } else if it[start..].starts_with("three") {
                    output.push('3');
                    // start += 4;
                } else if it[start..].starts_with("four") {
                    output.push('4');
                    // start += 3;
                } else if it[start..].starts_with("five") {
                    output.push('5');
                    // start += 3;
                } else if it[start..].starts_with("six") {
                    output.push('6');
                    // start += 2;
                } else if it[start..].starts_with("seven") {
                    output.push('7');
                    // start += 4;
                } else if it[start..].starts_with("eight") {
                    output.push('8');
                    // start += 4;
                } else if it[start..].starts_with("nine") {
                    output.push('9');
                    // start += 3;
                } else {
                    if start < it.len() {
                        output.push_str(&it[start..start + 1]);
                    }
                }
                start += 1;
            }
            let first: u32 = output
                .as_str()
                .chars()
                .find_map(|it| it.to_digit(10))
                .unwrap();
            let last: u32 = output
                .as_str()
                .chars()
                .filter_map(|it| it.to_digit(10))
                .next_back()
                .unwrap();
            dbg!(first * 10 + last)
        })
        .sum()
}

#[test]
fn part1_ex() {
    assert_eq!(
        part1(
            r"
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
            "
        ),
        142
    )
}

#[test]
fn part2_ex() {
    assert_eq!(
        part2(
            r"
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen  
        "
        ),
        281
    )
}
