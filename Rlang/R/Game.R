game <- list(
    players = character(),
    places = rep(0, 6),
    purses = rep(0, 6),
    in_penalty_box = rep(FALSE, 6),

    pop_questions = character(),
    science_questions = character(),
    sports_questions = character(),
    rock_questions = character(),

    current_player = 0,
    is_getting_out_of_penalty_box = FALSE
  )

init_game <- function() {
  game <<- list(
    players = character(),
    places = rep(0, 6),
    purses = rep(0, 6),
    in_penalty_box = rep(FALSE, 6),

    pop_questions = character(),
    science_questions = character(),
    sports_questions = character(),
    rock_questions = character(),

    current_player = 0,
    is_getting_out_of_penalty_box = FALSE
  )

  for (i in 0:49) {
    game$pop_questions <<- c(game$pop_questions, paste("Pop Question", i))
    game$science_questions <<- c(game$science_questions, paste("Science Question", i))
    game$sports_questions <<- c(game$sports_questions, paste("Sports Question", i))
    game$rock_questions <<- c(game$rock_questions, create_rock_question(i))
  }
}

create_rock_question <- function(index) {
  paste("Rock Question", index)
}

how_many_players <- function() {
  length(game$players)
}

is_playable <- function() {
  how_many_players() >= 2
}

add_player <- function(player_name) {
  game$players <<- c(game$players, player_name)
  idx <- how_many_players()

  game$places[idx] <<- 0
  game$purses[idx] <<- 0
  game$in_penalty_box[idx] <<- FALSE

  cat(player_name, "was added\n")
  cat("They are player number", length(game$players), "\n")

  TRUE
}

current_category <- function() {

  if (game$places[game$current_player + 1] == 0) return("Pop")
  if (game$places[game$current_player + 1] == 6) return("Sports")
  if (game$places[game$current_player + 1] == 4) return("Pop")
  if (game$places[game$current_player + 1] == 9) return("Science")
  if (game$places[game$current_player + 1] == 8) return("Pop")
  if (game$places[game$current_player + 1] == 1) return("Science")
  if (game$places[game$current_player + 1] == 2) return("Sports")
  if (game$places[game$current_player + 1] == 5) return("Science")
  if (game$places[game$current_player + 1] == 10) return("Sports")

  "Rock"
}

ask_question <- function() {
  if (current_category() == "Pop") {
    cat(game$pop_questions[1], "\n")
    game$pop_questions <<- game$pop_questions[-1]
  }

  if (current_category() == "Science") {
    cat(game$science_questions[1], "\n")
    game$science_questions <<- game$science_questions[-1]
  }

  if (current_category() == "Sports") {
    cat(game$sports_questions[1], "\n")
    game$sports_questions <<- game$sports_questions[-1]
  }

  if (current_category() == "Rock") {
    cat(game$rock_questions[1], "\n")
    game$rock_questions <<- game$rock_questions[-1]
  }
}

roll <- function(roll) {
  cat(game$players[game$current_player + 1], "is the current player\n")
  cat("They have rolled a", roll, "\n")

  if (game$in_penalty_box[game$current_player + 1]) {
    if (roll %% 2 != 0) {
      game$is_getting_out_of_penalty_box <<- TRUE

      cat(game$players[game$current_player + 1],
          "is getting out of the penalty box\n")

      game$places[game$current_player + 1] <<-
        game$places[game$current_player + 1] + roll

      if (game$places[game$current_player + 1] > 11) {
        game$places[game$current_player + 1] <<-
          game$places[game$current_player + 1] - 12
      }

      cat(game$players[game$current_player + 1],
          "'s new location is",
          game$places[game$current_player + 1], "\n")

      cat("The category is", current_category(), "\n")
      ask_question()

    } else {
      cat(game$players[game$current_player + 1],
          "is not getting out of the penalty box\n")
      game$is_getting_out_of_penalty_box <<- FALSE
    }

  } else {

    game$places[game$current_player + 1] <<-
      game$places[game$current_player + 1] + roll

    if (game$places[game$current_player + 1] > 11) {
      game$places[game$current_player + 1] <<- game$places[game$current_player + 1] - 12
    }

    cat(game$players[game$current_player + 1],
        "'s new location is",
        game$places[game$current_player + 1], "\n")

    cat("The category is", current_category(), "\n")
    ask_question()
  }
}

was_correctly_answered <- function() {

  if (game$in_penalty_box[game$current_player + 1]) {

    if (game$is_getting_out_of_penalty_box) {

      cat("Answer was correct!!!!\n")
      game$purses[game$current_player + 1] <<-
        game$purses[game$current_player + 1] + 1

      cat(game$players[game$current_player + 1],
          "now has",
          game$purses[game$current_player + 1],
          "Gold Coins.\n")

      winner <- did_player_win()

      game$current_player <<- game$current_player + 1
      if (game$current_player == length(game$players))
        game$current_player <<- 0

      return(winner)

    } else {

      game$current_player <<- game$current_player + 1
      if (game$current_player == length(game$players))
        game$current_player <<- 0

      return(TRUE)
    }

  } else {

    cat("Answer was corrent!!!!\n")
    game$purses[game$current_player + 1] <<-
      game$purses[game$current_player + 1] + 1

    cat(game$players[game$current_player + 1],
        "now has",
        game$purses[game$current_player + 1],
        "Gold Coins.\n")

    winner <- did_player_win()

    game$current_player <<- game$current_player + 1
    if (game$current_player == length(game$players))
      game$current_player <<- 0

    return(winner)
  }
}

wrong_answer <- function() {
  cat("Question was incorrectly answered\n")
  cat(game$players[game$current_player + 1],
      "was sent to the penalty box\n")

  game$in_penalty_box[game$current_player + 1] <<- TRUE

  game$current_player <<- game$current_player + 1
  if (game$current_player == length(game$players))
    game$current_player <<- 0

  TRUE
}

did_player_win <- function() {
  game$purses[game$current_player + 1] != 6
}