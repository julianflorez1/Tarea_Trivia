source("R/Game.R")

init_game()

add_player("Chet")
add_player("Pat")
add_player("Sue")

not_a_winner <- TRUE

while (TRUE) {
  roll(sample(1:6, 1))

  if (sample(0:8, 1) == 7) {
    not_a_winner <- wrong_answer()
  } else {
    not_a_winner <- was_correctly_answered()
  }

  if (!not_a_winner) break
}
