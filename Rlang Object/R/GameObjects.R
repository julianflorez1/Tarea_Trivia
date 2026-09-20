library(R6)

Game <- R6Class(
  "Game",
  public = list(
    players = NULL,
    places = NULL,
    purses = NULL,
    in_penalty_box = NULL,

    pop_questions = NULL,
    science_questions = NULL,
    sports_questions = NULL,
    rock_questions = NULL,

    current_player = NULL,
    is_getting_out_of_penalty_box = NULL,


    initialize = function() {
      self$players <- character()
      self$places <- rep(0, 6)
      self$purses <- rep(0, 6)
      self$in_penalty_box <- rep(FALSE, 6)

      self$pop_questions <- character()
      self$science_questions <- character()
      self$sports_questions <- character()
      self$rock_questions <- character()

      self$current_player <- 0
      self$is_getting_out_of_penalty_box <- FALSE

      for (i in 0:49) {
        self$pop_questions <- c(self$pop_questions, paste0("Pop Question ", i))
        self$science_questions <- c(self$science_questions, paste0("Science Question ", i))
        self$sports_questions <- c(self$sports_questions, paste0("Sports Question ", i))
        self$rock_questions <- c(self$rock_questions, self$create_rock_question(i))
      }
    }

    ,


    is_playable = function() {
    length(self$players) >= 2
},

    add = function(player_name) {
    self$players <- c(self$players, player_name)
    idx <- length(self$players)
    self$places[idx] <- 0
    self$purses[idx] <- 0
    self$in_penalty_box[idx] <- FALSE
    cat(player_name, "was added\n")
    cat("They are player number", idx, "\n")
    TRUE
},
    create_rock_question = function(index) {
      paste("Rock Question", index)
    },

    roll = function(roll) {
      cat(self$players[self$current_player + 1], "is the current player\n")
      cat("They have rolled a", roll, "\n")

      if (self$in_penalty_box[self$current_player + 1]) {
        if (roll %% 2 != 0) {
          self$is_getting_out_of_penalty_box <- TRUE
          cat(self$players[self$current_player + 1], "is getting out of the penalty box\n")
          self$places[self$current_player + 1] <- self$places[self$current_player + 1] + roll
          if (self$places[self$current_player + 1] > 11) {
            self$places[self$current_player + 1] <- self$places[self$current_player + 1] - 12
          }
          cat(self$players[self$current_player + 1], "'s new location is ",
              self$places[self$current_player + 1], "\n")
          cat("The category is", self$current_category(), "\n")
          self$ask_question()
        } else {
          cat(self$players[self$current_player + 1], "is not getting out of the penalty box\n")
          self$is_getting_out_of_penalty_box <- FALSE
        }
      } else {
        self$places[self$current_player + 1] <- self$places[self$current_player + 1] + roll
        if (self$places[self$current_player + 1] > 11) {
          self$places[self$current_player + 1] <- self$places[self$current_player + 1] - 12
        }
        cat(self$players[self$current_player + 1], "'s new location is ",
            self$places[self$current_player + 1], "\n")
        cat("The category is", self$current_category(), "\n")
        self$ask_question()
      }
    },

    ask_question = function() {
      category <- self$current_category()
      if (category == "Pop") {
        q <- self$pop_questions[1]
        self$pop_questions <- self$pop_questions[-1]
        cat(q, "\n")
      }

      if (self$current_category() == "Science") {
        q <- self$science_questions[1]
        self$science_questions <- self$science_questions[-1]
        cat(q, "\n")
      }

      if (category == "Sports") {
        cat(game$sports_questions[1], "\n")
        game$sports_questions <<- game$sports_questions[-1]
      }

      if (category == "Rock") {
        q <- self$rock_questions[1]
        self$rock_questions <- self$rock_questions[-1]
        cat(q, "\n")
      }
    },

    current_category = function() {
      pos <- self$places[self$current_player + 1]

      if (pos == 0) return("Pop")
      if (pos == 6) return("Sports")
      if (pos == 4) return("Pop")
      if (pos == 9) return("Science")
      if (pos == 8) return("Pop")
      if (pos == 1) return("Science")
      if (pos == 2) return("Sports")
      if (pos == 5) return("Science")
      if (pos == 10) return("Sports")

      "Rock"
    },

    was_correctly_answered = function() {
      if (self$in_penalty_box[self$current_player + 1]) {
        if (self$is_getting_out_of_penalty_box) {
          cat("Answer was correct!!!!\n")
          self$purses[self$current_player + 1] <- self$purses[self$current_player + 1] + 1
          cat(self$players[self$current_player + 1], "now has", self$purses[self$current_player + 1], "Gold Coins.\n")
          winner <- self$did_player_win()
          self$current_player <- (self$current_player + 1) %% length(self$players)
          return(winner)
        } else {
          self$current_player <- (self$current_player + 1) %% length(self$players)
          return(TRUE)
        }
      } else {
        idx <- self$current_player + 1
        cat("Answer was corrent!!!!\n")
        self$purses[idx] <- self$purses[idx] + 1
        cat(self$players[idx], "now has", self$purses[self$current_player + 1], "Gold Coins.\n")
        winner <- self$did_player_win()
        self$current_player <- (self$current_player + 1) %% length(self$players)
        return(winner)
      }
    },

    wrong_answer = function() {
      cat("Question was incorrectly answered\n")
      cat(self$players[self$current_player + 1], "was sent to the penalty box\n")
      self$in_penalty_box[self$current_player + 1] <- TRUE
      self$current_player <- (self$current_player + 1) %% length(self$players)
      TRUE
    },

    did_player_win = function() {
      !(self$purses[self$current_player + 1] == 6)
    }
  )
)
