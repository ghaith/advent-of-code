pub fn run() {
    let required = Cube {
        red: 12,
        green: 13,
        blue: 14,
    };

    let input = std::include_str!("day2/input.txt");
    println!("{}", part1(input, &required));
    println!("{}", part2(input));
}

struct Cube {
    red: i32,
    green: i32,
    blue: i32,
}

struct Game {
    num: i32,
    lots: Vec<Cube>,
}

impl From<&str> for Game {
    fn from(value: &str) -> Self {
        let &[num, lots] = &value[5..].split(':').collect::<Vec<&str>>()[..] else {
            panic!("{value}");
        };
        let num: i32 = num.parse().unwrap();
        let lots: Vec<Cube> = lots.split(';').map(|lot| lot.into()).collect();
        Game { num, lots }
    }
}

impl From<&str> for Cube {
    fn from(value: &str) -> Self {
        let mut res = Cube {
            red: 0,
            green: 0,
            blue: 0,
        };
        value
            .split(',')
            .map(|it| {
                let &[num, name] = &it.trim().split(' ').collect::<Vec<&str>>()[..] else {
                    panic!("{it}");
                };
                (num.parse::<i32>().unwrap(), name)
            })
            .for_each(|(num, name)| match name {
                "red" => res.red = num,
                "green" => res.green = num,
                "blue" => res.blue = num,
                _ => panic!("{name}"),
            });
        res
    }
}

impl Game {
    fn is_valid(&self, required: &Cube) -> bool {
        self.lots.iter().all(|it| it.is_valid(required))
    }

    fn find_min(&self) -> Cube {
        let res = Cube {
            red: 0,
            green: 0,
            blue: 0,
        };

        self.lots.iter().fold(res, |left, right| Cube {
            red: left.red.max(right.red),
            green: left.green.max(right.green),
            blue: left.blue.max(right.blue),
        })
    }
}

impl Cube {
    fn is_valid(&self, req: &Cube) -> bool {
        self.red <= req.red && self.green <= req.green && self.blue <= req.blue
    }

    fn pow(&self) -> i32 {
        self.red * self.green * self.blue
    }
}

fn part1(input: &str, required: &Cube) -> i32 {
    let games: Vec<Game> = input
        .lines()
        .filter(|it| !it.trim().is_empty())
        .map(Into::into)
        .collect();

    games
        .iter()
        .filter(|it| it.is_valid(required))
        .map(|it| it.num)
        .sum()
}

fn part2(input: &str) -> i32 {
    input
        .lines()
        .filter(|it| !it.trim().is_empty())
        .map(Into::into)
        .map(|it: Game| it.find_min())
        .map(|it| it.pow())
        .sum()
}

#[test]
fn test_part1() {
    let required = Cube {
        red: 12,
        green: 13,
        blue: 14,
    };
    let input = r"
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        ";

    assert_eq!(part1(input, &required), 8);
}

#[test]
fn test_part2() {
    let input = r"
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        ";

    assert_eq!(part2(input), 2286);
}
