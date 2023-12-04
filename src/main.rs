mod day1;
mod day2;
mod day3;
mod day4;
fn main() {
    let days = &[day1::run, day2::run, day3::run, day4::run];
    let day: Option<usize> = std::env::args()
        .skip(1)
        .next()
        .map(|it| it.parse().expect("Expecting an int"));
    if let Some(day) = day {
        days[day - 1]();
    } else {
        for day in days {
            day();
        }
    }
}
