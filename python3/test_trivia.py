import contextlib
import io
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from trivia import Game


class GameTests(unittest.TestCase):
    def test_initializes_fifty_questions_per_category(self):
        game = Game()

        self.assertEqual(len(game.pop_questions), 50)
        self.assertEqual(len(game.science_questions), 50)
        self.assertEqual(len(game.sports_questions), 50)
        self.assertEqual(len(game.rock_questions), 50)

    def test_add_supports_six_players_without_shifting_state(self):
        game = Game()

        for player_name in ("Chet", "Pat", "Sue", "Ann", "Bob", "Liz"):
            with contextlib.redirect_stdout(io.StringIO()):
                game.add(player_name)

        self.assertEqual(game.how_many_players, 6)
        self.assertEqual(game.places, [0] * 6)
        self.assertEqual(game.purses, [0] * 6)
        self.assertEqual(game.in_penalty_box, [False] * 6)
        self.assertTrue(game.is_playable())

    def test_categories_follow_board_positions(self):
        game = Game()
        game.add("Chet")

        expected_categories = {
            0: "Pop",
            1: "Science",
            2: "Sports",
            3: "Rock",
            4: "Pop",
            5: "Science",
            6: "Sports",
        }

        for position, category in expected_categories.items():
            game.places[0] = position
            self.assertEqual(game._current_category, category)

    def test_wrong_answer_sends_current_player_to_penalty_box(self):
        game = Game()
        game.add("Chet")
        game.add("Pat")

        with contextlib.redirect_stdout(io.StringIO()):
            result = game.wrong_answer()

        self.assertTrue(result)
        self.assertTrue(game.in_penalty_box[0])
        self.assertEqual(game.current_player, 1)

    def test_correct_answer_increases_purse_and_rotates_player(self):
        game = Game()
        game.add("Chet")
        game.add("Pat")

        with contextlib.redirect_stdout(io.StringIO()):
            result = game.was_correctly_answered()

        self.assertTrue(result)
        self.assertEqual(game.purses[0], 1)
        self.assertEqual(game.current_player, 1)


if __name__ == "__main__":
    unittest.main()
