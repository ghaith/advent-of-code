use std::collections::{HashMap, HashSet};

fn main() {
    let input = "
        start-co
        ip-WE
        end-WE
        le-ls
        wt-zi
        end-sz
        wt-RI
        wt-sz
        zi-start
        wt-ip
        YT-sz
        RI-start
        le-end
        ip-sz
        WE-sz
        le-WE
        le-wt
        zi-ip
        RI-zi
        co-zi
        co-le
        WB-zi
        wt-WE
        co-RI
        RI-ip

        ";

        let res = parse_input(input);
        let part_1 = count_pathes(&res, "start", "end", &mut vec![]);
        let part_2 = count_pathes_2(&res, "start", "end", &mut vec![], None);
        println!("Part1 : {}. Part2 : {}", part_1, part_2);
}

fn parse_input(input: &str) -> HashMap<String, Vec<String>> {
    let mut adj: HashMap<String, Vec<String>> = HashMap::new();

    for line in input.lines() {
        if let Some((a, b)) = line.trim().split_once('-') {
            let connections = adj.entry(a.to_string()).or_insert_with(|| vec![]);
            connections.push(b.to_string());
            let connections = adj.entry(b.to_string()).or_insert_with(|| vec![]);
            connections.push(a.to_string());
        }
    }

    adj
}

fn count_pathes(
    map: &HashMap<String, Vec<String>>,
    start: &str,
    end: &str,
    visited: &mut Vec<String>,
    // scores : &mut HashMap<String, u32>,
) -> u32 {
    let mut count = 0;
    visited.push(start.to_string());
    if start == end {
        // println!("{:?}", visited);
        count += 1;
    } else {
        let neighbours = map.get(start).unwrap();
        for n in neighbours {
            if !visited
                .iter()
                .map(|it| it.as_str())
                .filter(|it| !is_uppercase(*it))
                .any(|it| it == n)
            {
                count += count_pathes(map, n, end, visited);
            }
        }
    }
    visited.pop();
    count
}

fn count_pathes_2(
    map: &HashMap<String, Vec<String>>,
    start: &str,
    end: &str,
    visited: &mut Vec<String>,
    visited_lower: Option<&str>,
) -> u32 {
    let mut count = 0;
    visited.push(start.to_string());
    let used = visited
        .iter()
        .map(|it| it.clone())
        .filter(|it| !is_uppercase(it))
        .collect::<Vec<String>>();
    if start == end {
        // println!("{:?}", visited);
        count += 1;
    } else {
        let neighbours = map.get(start).unwrap();
        for n in neighbours {
            if n != "start" {
                if used.contains(n) && visited_lower.is_none() {
                    count += count_pathes_2(map, n, end, visited, Some(n.as_str()));
                } else if !used.contains(n) {
                    count += count_pathes_2(map, n, end, visited, visited_lower);
                }
            }
        }
    }
    visited.pop();
    count
}

fn is_uppercase(s: &str) -> bool {
    &s.to_uppercase() == s
}

#[cfg(test)]
mod tests {
    use std::collections::HashSet;

    use crate::{count_pathes, count_pathes_2, parse_input};

    #[test]
    fn test_input_1() {
        let input = "
        start-A
        start-b
        A-c
        A-b
        b-d
        A-end
        b-end
        ";

        let res = parse_input(input);
        assert_eq!(10, count_pathes(&res, "start", "end", &mut vec![]));
        assert_eq!(36, count_pathes_2(&res, "start", "end", &mut vec![], None));
    }

    #[test]
    fn test_input_2() {
        let input = "
        dc-end
        HN-start
        start-kj
        dc-start
        dc-HN
        LN-dc
        HN-end
        kj-sa
        kj-HN
        kj-dc 
        ";

        let res = parse_input(input);
        assert_eq!(19, count_pathes(&res, "start", "end", &mut vec![]));
        assert_eq!(103, count_pathes_2(&res, "start", "end", &mut vec![], None));
    }

    #[test]
    fn test_input_3() {
        let input = "
        fs-end
        he-DX
        fs-he
        start-DX
        pj-DX
        end-zg
        zg-sl
        zg-pj
        pj-he
        RW-he
        fs-DX
        pj-RW
        zg-RW
        start-pj
        he-WI
        zg-he
        pj-fs
        start-RW
        ";

        let res = parse_input(input);
        assert_eq!(226, count_pathes(&res, "start", "end", &mut vec![]));
        assert_eq!(3509, count_pathes_2(&res, "start", "end", &mut vec![], None));
    }

    #[test]
    fn part_1() {
        let input = "
        start-co
        ip-WE
        end-WE
        le-ls
        wt-zi
        end-sz
        wt-RI
        wt-sz
        zi-start
        wt-ip
        YT-sz
        RI-start
        le-end
        ip-sz
        WE-sz
        le-WE
        le-wt
        zi-ip
        RI-zi
        co-zi
        co-le
        WB-zi
        wt-WE
        co-RI
        RI-ip

        ";

        let res = parse_input(input);
        let mut visited = vec!["start".to_string()];
        assert_eq!(5756, count_pathes(&res, "start", "end", &mut visited));
        assert_eq!(144603, count_pathes_2(&res, "start", "end", &mut visited, None));
    }
}
