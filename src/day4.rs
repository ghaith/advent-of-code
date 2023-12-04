pub fn run() {
    let input = std::include_str!("day4/input.txt");
    println!("Running Day 4");
    println!("-----------------");
    println!("Part 1 : {}", part1(input));
    println!("-----------------");
    println!("Part 2: {}", part2(input));
    println!("-----------------");
}

fn part1(input: &str) -> i32 {
    input
        .lines()
        .filter(|it| !it.trim().is_empty())
        .map(Into::into)
        .map(|it: Card| it.get_value())
        .sum()
}

fn part2(input: &str) -> i32 {
    let mut cards = input
        .lines()
        .filter(|it| !it.trim().is_empty())
        .map(Into::into)
        .collect::<Vec<Card>>();

    let mut i = 0;
    while i < cards.len() {
        for card in cards[i].process_winnings() {
            let count = cards[i].count;
            if let Some(card) = cards.get_mut(card as usize) {
                card.count += count;
            }
        }
        i += 1;
    }
    cards.iter().map(|it| it.count).sum()
}

#[derive(Debug)]
struct Card {
    card_number: i32,
    count: i32,
    winning: Vec<i32>,
    numbers: Vec<i32>,
}

impl Card {
    fn get_value(&self) -> i32 {
        let winnings = self
            .numbers
            .iter()
            .filter(|it| self.winning.contains(it))
            .count() as u32;
        if winnings > 0 {
            2_i32.pow(winnings - 1)
        } else {
            0
        }
    }

    fn process_winnings(&self) -> Vec<i32> {
        let winnings = self
            .numbers
            .iter()
            .filter(|it| self.winning.contains(it))
            .count();
        (0..winnings)
            .map(|it| self.card_number + it as i32)
            .collect()
    }
}

impl From<&str> for Card {
    fn from(value: &str) -> Self {
        if let &[name, value] = &value.split(':').collect::<Vec<&str>>()[..] {
            let card_number = name
                .split_whitespace()
                .skip(1)
                .next()
                .expect("Expecting card number in {name}")
                .parse()
                .expect("Expecting int {name}");
            if let &[winning, numbers] = &value.split('|').collect::<Vec<&str>>()[..] {
                let winning = winning
                    .split_whitespace()
                    .map(|it| it.parse().expect("{it} not a numbers"))
                    .collect::<Vec<i32>>();
                let numbers = numbers
                    .split_whitespace()
                    .map(|it| it.parse().expect("{it} not a numbers"))
                    .collect::<Vec<i32>>();
                Card {
                    card_number,
                    count: 1,
                    winning,
                    numbers,
                }
            } else {
                panic!("Invalid input {value}");
            }
        } else {
            panic!("Invalid input {value}");
        }
    }
}

#[test]
fn test_part1() {
    let input = r"
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    ";

    assert_eq!(part1(input), 13);
}

#[test]
fn test_part2() {
    let input = r"
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    ";

    assert_eq!(part2(input), 30);
}
