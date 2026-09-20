source("R/GameObjects.R")

game <- Game$new()

game$add("Chet")
game$add("Pat")
game$add("Sue")

not_a_winner <- TRUE

while (not_a_winner) {
  roll_val <- sample(1:6, 1)
  game$roll(roll_val)

  if (sample(0:8, 1) == 7) {
    not_a_winner <- game$wrong_answer()
  } else {
    not_a_winner <- game$was_correctly_answered()
  }
}
