require_relative "test_helper"
require "Chessington/engine"

class TestPieces < Minitest::Test
  class TestPawn < Minitest::Test
    include Chessington::Engine

    def test_white_pawns_can_move_up_one_square
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(1, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(2, 4))
    end

    def test_black_pawns_can_move_down_one_square
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(6, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(5, 4))
    end

    def test_white_pawn_can_move_up_two_squares_if_not_moved
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(1, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(3, 4))
    end

    def test_black_pawn_can_move_down_two_squares_if_not_moved
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(6, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(4, 4))
    end

    def test_white_pawn_cannot_move_up_two_squares_if_already_moved
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      starting_square = Square.at(1, 4)
      board.set_piece(starting_square, pawn)

      intermediate_square = Square.at(2, 4)
      pawn.move_to(board, intermediate_square)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 4))
    end

    def test_black_pawn_cannot_move_down_two_squares_if_already_moved
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      starting_square = Square.at(6, 4)
      board.set_piece(starting_square, pawn)

      intermediate_square = Square.at(5, 4)
      pawn.move_to(board, intermediate_square)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(3, 4))
    end

    def test_white_pawn_cannot_move_if_piece_in_front
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(4, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(5, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)
    end

    def test_black_pawn_cannot_move_if_piece_in_front
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(4, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(3, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)
    end

    def test_white_pawn_cannot_move_two_squares_if_piece_two_in_front
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(1, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(3, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, obstructing_square)
    end

    def test_black_pawn_cannot_move_two_squares_if_piece_two_in_front
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(6, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(4, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, obstructing_square)
    end

    def test_white_pawn_cannot_move_two_squares_if_piece_one_in_front
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(1, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(2, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(3, 4))
    end

    def test_black_pawn_cannot_move_two_squares_if_piece_one_in_front
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(6, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(5, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 4))
    end

    def test_white_pawn_cannot_move_at_top_of_board
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(7, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)
    end

    def test_black_pawn_cannot_move_at_bottom_of_board
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(0, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)
    end

    def test_white_pawns_can_capture_diagonally
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      enemy1 = Pawn.new(Player::BLACK)
      enemy1_square = Square.at(4, 5)
      board.set_piece(enemy1_square, enemy1)

      enemy2 = Pawn.new(Player::BLACK)
      enemy2_square = Square.at(4, 3)
      board.set_piece(enemy2_square, enemy2)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, enemy1_square)
      assert_includes(moves, enemy2_square)
    end

    def test_black_pawns_can_capture_diagonally
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      enemy1 = Pawn.new(Player::WHITE)
      enemy1_square = Square.at(2, 5)
      board.set_piece(enemy1_square, enemy1)

      enemy2 = Pawn.new(Player::WHITE)
      enemy2_square = Square.at(2, 3)
      board.set_piece(enemy2_square, enemy2)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, enemy1_square)
      assert_includes(moves, enemy2_square)
    end

    def test_white_pawns_cannot_move_diagonally_except_to_capture
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(4, 5)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 3))
      refute_includes(moves, Square.at(4, 5))
    end

    def test_black_pawns_cannot_move_diagonally_except_to_capture
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(2, 5)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(2, 3))
      refute_includes(moves, Square.at(2, 5))
    end

    def test_white_pawns_take_pawn_left
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 3)
      board.set_piece(pawn_square, pawn)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(4, 2)
      board.set_piece(enemy_square, enemy)

      # Act
      board.move_piece(pawn_square, enemy_square)

      # Assert
      assert_nil(board.get_piece(pawn_square))
      assert_equal(pawn, board.get_piece(enemy_square))
    end

    def test_black_pawns_take_pawn_left
      # Arrange
      board = Board.empty
      board.current_player = Player::BLACK
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(4, 3)
      board.set_piece(pawn_square, pawn)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(3, 4)
      board.set_piece(enemy_square, enemy)

      # Act
      board.move_piece(pawn_square, enemy_square)

      # Assert
      assert_nil(board.get_piece(pawn_square))
      assert_equal(pawn, board.get_piece(enemy_square))
    end

    def test_white_pawns_take_pawn_right
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 3)
      board.set_piece(pawn_square, pawn)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(4, 4)
      board.set_piece(enemy_square, enemy)

      # Act
      board.move_piece(pawn_square, enemy_square)

      # Assert
      assert_nil(board.get_piece(pawn_square))
      assert_equal(pawn, board.get_piece(enemy_square))
    end

    def test_black_pawns_take_pawn_right
      # Arrange
      board = Board.empty
      board.current_player = Player::BLACK
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(4, 3)
      board.set_piece(pawn_square, pawn)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(3, 2)
      board.set_piece(enemy_square, enemy)

      # Act
      board.move_piece(pawn_square, enemy_square)

      # Assert
      assert_nil(board.get_piece(pawn_square))
      assert_equal(pawn, board.get_piece(enemy_square))
    end

    def test_white_pawns_cannot_take_own_piece_left
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 3)
      board.set_piece(pawn_square, pawn)

      friendly_left = Pawn.new(Player::WHITE)
      friendly_left_square = Square.at(4, 2)
      board.set_piece(friendly_left_square, friendly_left)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, friendly_left_square)
    end

    def test_white_pawns_cannot_take_own_piece_right
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 3)
      board.set_piece(pawn_square, pawn)

      friendly_right = Pawn.new(Player::WHITE)
      friendly_right_square = Square.at(4, 4)
      board.set_piece(friendly_right_square, friendly_right)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, friendly_right_square)
    end

    def test_black_pawns_cannot_take_own_piece_left
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(4, 3)
      board.set_piece(pawn_square, pawn)

      friendly_left = Pawn.new(Player::BLACK)
      friendly_left_square = Square.at(3, 4)
      board.set_piece(friendly_left_square, friendly_left)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, friendly_left_square)
    end

    def test_black_pawns_cannot_take_own_piece_right
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(4, 3)
      board.set_piece(pawn_square, pawn)

      friendly_right = Pawn.new(Player::BLACK)
      friendly_right_square = Square.at(3, 2)
      board.set_piece(friendly_right_square, friendly_right)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, friendly_right_square)
    end

    def test_white_pawns_cannot_take_king_left
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 3)
      board.set_piece(pawn_square, pawn)

      king_left = King.new(Player::BLACK)
      king_left_square = Square.at(4, 2)
      board.set_piece(king_left_square, king_left)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, king_left_square)
    end

    def test_white_pawns_cannot_take_king_right
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 3)
      board.set_piece(pawn_square, pawn)

      king_right = King.new(Player::BLACK)
      king_right_square = Square.at(4, 4)
      board.set_piece(king_right_square, king_right)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, king_right_square)
    end

    def test_black_pawns_cannot_take_king_left
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(4, 3)
      board.set_piece(pawn_square, pawn)

      king_left = King.new(Player::WHITE)
      king_left_square = Square.at(3, 4)
      board.set_piece(king_left_square, king_left)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, king_left_square)
    end

    def test_black_pawns_cannot_take_king_right
      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(4, 3)
      board.set_piece(pawn_square, pawn)

      king_right = King.new(Player::WHITE)
      king_right_square = Square.at(3, 2)
      board.set_piece(king_right_square, king_right)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, king_right_square)
    end
  end

  class TestBishop < Minitest::Test
    include Chessington::Engine
    def test_white_bishops_can_move_NE_one
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(1, 1))
    end

    def test_black_bishops_can_move_NE_one
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(1, 1))
    end

    def test_white_bishops_can_move_SE_one
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(1, 0)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(0, 1))
    end

    def test_black_bishops_can_move_SE_one
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::BLACK)
      square = Square.at(1, 0)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(0, 1))
    end

    def test_white_bishops_can_move_SW_one
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(1, 1)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(0, 0))
    end

    def test_black_bishops_can_move_SW_one
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::BLACK)
      square = Square.at(1, 1)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(0, 0))
    end

    def test_white_bishops_can_move_NW_one
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(0, 1)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(1, 0))
    end

    def test_black_bishops_can_move_NW_one
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::BLACK)
      square = Square.at(0, 1)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(1, 0))
    end

    def test_white_bishops_can_move_NE_many
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      (1..7).each do |i|
        assert_includes(moves, Square.at(i, i))
      end
    end

    def test_black_bishops_can_move_NE_many
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      (1..7).each do |i|
        assert_includes(moves, Square.at(i, i))
      end
    end

    def test_white_bishops_can_move_SE_many
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(7, 0)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      (0..6).each do |i|
        assert_includes(moves, Square.at(i, 7 - i))
      end
    end

    def test_black_bishops_can_move_SE_many
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::BLACK)
      square = Square.at(7, 0)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      (0..6).each do |i|
        assert_includes(moves, Square.at(i, 7 - i))
      end
    end

    def test_white_bishops_can_move_SW_many
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(7, 7)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      (0..6).each do |i|
        assert_includes(moves, Square.at(i, i))
      end
    end

    def test_black_bishops_can_move_SW_many
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::BLACK)
      square = Square.at(7, 7)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      (0..6).each do |i|
        assert_includes(moves, Square.at(i, i))
      end
    end

    def test_white_bishops_can_move_NW_many
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(0, 7)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      (1..7).each do |i|
        assert_includes(moves, Square.at(i, 7 - i))
      end
    end

    def test_black_bishops_can_move_NW_many
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::BLACK)
      square = Square.at(0, 7)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      (1..7).each do |i|
        assert_includes(moves, Square.at(i, 7 - i))
      end
    end

    def test_white_bishops_can_only_move_diagonally
      # Arrange
      board = Board.empty
      row = 3
      col = 3
      bishop = Bishop.new(Player::WHITE)
      square = Square.at(row, col)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      moves.each do |move|
        row_diff = move.row - row
        col_diff = move.column - col
        assert row_diff == col_diff || row_diff == -col_diff, "Move not diagonal of bishop"
      end
    end

    def test_black_bishops_can_only_move_horizontally_or_vertically
      # Arrange
      board = Board.empty
      row = 3
      col = 3
      bishop = Bishop.new(Player::BLACK)
      square = Square.at(row, col)
      board.set_piece(square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      moves.each do |move|
        row_diff = move.row - row
        col_diff = move.column - col
        assert row_diff == col_diff || row_diff == -col_diff, "Move not diagonal of bishop"
      end
    end

    def test_white_bishop_cannot_move_NE_onto_friendly_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, bishop)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(1, 1)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_black_bishop_cannot_move_NE_onto_friendly_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, bishop)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(1, 1)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_white_bishop_cannot_move_SE_onto_friendly_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(1, 0)
      board.set_piece(square, bishop)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(0, 1)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_black_bishop_cannot_move_SE_onto_friendly_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::BLACK)
      square = Square.at(1, 0)
      board.set_piece(square, bishop)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(0, 1)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_white_bishop_cannot_move_SW_onto_friendly_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(7, 7)
      board.set_piece(square, bishop)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(6, 6)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_black_bishop_cannot_move_SW_onto_friendly_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::BLACK)
      square = Square.at(7, 7)
      board.set_piece(square, bishop)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(6, 6)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_white_bishop_cannot_move_NW_onto_friendly_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(0, 7)
      board.set_piece(square, bishop)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(1, 6)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_black_bishop_cannot_move_NW_onto_friendly_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::BLACK)
      square = Square.at(0, 7)
      board.set_piece(square, bishop)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(1, 6)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_white_bishop_cannot_move_NE_through_black_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(1, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(2, 2))
    end

    def test_black_bishop_cannot_move_NE_through_white_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(1, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(2, 2))
    end

    def test_white_bishop_cannot_move_SE_through_black_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(7, 0)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(6, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(5, 2))
    end

    def test_black_bishop_cannot_move_SE_through_white_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::BLACK)
      square = Square.at(7, 0)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(6, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(5, 2))
    end

    def test_white_bishop_cannot_move_SW_through_black_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(7, 7)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(6, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(5, 5))
    end

    def test_black_bishop_cannot_move_SW_through_white_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(7, 7)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(6, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(5, 5))
    end

    def test_white_bishop_cannot_move_NW_through_black_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(0, 7)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(1, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(2, 5))
    end

    def test_black_bishop_cannot_move_NW_through_white_piece
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::BLACK)
      square = Square.at(0, 7)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(1, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(2, 5))
    end

    def test_white_bishop_can_take_black_piece_NE
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(1, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_black_bishop_can_take_white_piece_NE
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(1, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_white_bishop_can_take_black_piece_SE
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(7, 0)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(6, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_black_bishop_can_take_white_piece_SE
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::BLACK)
      square = Square.at(7, 0)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(6, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_white_bishop_can_take_black_piece_SW
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(7, 7)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(6, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_black_bishop_can_take_white_piece_SW
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::BLACK)
      square = Square.at(7, 7)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(6, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_white_bishop_can_take_black_piece_NW
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::WHITE)
      square = Square.at(0, 7)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(1, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_black_bishop_can_take_white_piece_NW
      # Arrange
      board = Board.empty

      bishop = Bishop.new(Player::BLACK)
      square = Square.at(0, 7)
      board.set_piece(square, bishop)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(1, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end
  end

  class TestRook < Minitest::Test
    include Chessington::Engine
    def test_white_rooks_can_move_up_one
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(1, 0))
    end

    def test_black_rooks_can_move_up_one
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(1, 0))
    end

    def test_white_rooks_can_move_down_one
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(1, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(0, 0))
    end

    def test_black_rooks_can_move_down_one
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::BLACK)
      square = Square.at(1, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(0, 0))
    end

    def test_white_rooks_can_move_left_one
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 1)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(0, 0))
    end

    def test_black_rooks_can_move_left_one
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 1)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(0, 0))
    end

    def test_white_rooks_can_move_right_one
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(0, 1))
    end

    def test_black_rooks_can_move_right_one
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(0, 1))
    end

    def test_white_rooks_can_move_up_many
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      (1..7).each do |i|
        assert_includes(moves, Square.at(i, 0))
      end
    end

    def test_black_rooks_can_move_up_many
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      (1..7).each do |i|
        assert_includes(moves, Square.at(i, 0))
      end
    end

    def test_white_rooks_can_move_down_many
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(7, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      (0..6).each do |i|
        assert_includes(moves, Square.at(i, 0))
      end
    end

    def test_black_rooks_can_move_down_many
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::BLACK)
      square = Square.at(7, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      (0..6).each do |i|
        assert_includes(moves, Square.at(i, 0))
      end
    end

    def test_white_rooks_can_move_left_many
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 7)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      (0..6).each do |i|
        assert_includes(moves, Square.at(0, i))
      end
    end

    def test_black_rooks_can_move_left_many
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 7)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      (0..6).each do |i|
        assert_includes(moves, Square.at(0, i))
      end
    end

    def test_white_rooks_can_move_right_many
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      (1..7).each do |i|
        assert_includes(moves, Square.at(0, i))
      end
    end

    def test_black_rooks_can_move_right_many
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      (1..7).each do |i|
        assert_includes(moves, Square.at(0, i))
      end
    end

    def test_white_rooks_can_only_move_horizontally_or_vertically
      # Arrange
      board = Board.empty
      row = 3
      col = 3
      rook = Rook.new(Player::WHITE)
      square = Square.at(row, col)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      moves.each do |move|
        assert move.row == row || move.column == col, "Move not in row or column of bishop"
      end
    end

    def test_black_rooks_can_only_move_horizontally_or_vertically
      # Arrange
      board = Board.empty
      row = 3
      col = 3
      rook = Rook.new(Player::BLACK)
      square = Square.at(row, col)
      board.set_piece(square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      moves.each do |move|
        assert move.row == row || move.column == col, "Move not in row or column of bishop"
      end
    end

    def test_white_rook_cannot_move_up_onto_friendly_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(1, 0)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_black_rook_cannot_move_up_onto_friendly_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(1, 0)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_white_rook_cannot_move_down_onto_friendly_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(1, 0)
      board.set_piece(square, rook)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(0, 0)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_black_rook_cannot_move_down_onto_friendly_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::BLACK)
      square = Square.at(1, 0)
      board.set_piece(square, rook)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(0, 0)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_white_rook_cannot_move_left_onto_friendly_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 7)
      board.set_piece(square, rook)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(0, 6)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_black_rook_cannot_move_left_onto_friendly_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 7)
      board.set_piece(square, rook)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(0, 6)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_white_rook_cannot_move_right_onto_friendly_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(0, 1)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_black_rook_cannot_move_right_onto_friendly_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(0, 1)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
    end

    def test_white_rook_cannot_move_up_through_black_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(0, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(0, 2))
    end

    def test_black_rook_cannot_move_up_through_white_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(0, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(0, 2))
    end

    def test_white_rook_cannot_move_down_through_black_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(7, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(6, 0)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(5, 0))
    end

    def test_black_rook_cannot_move_down_through_white_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::BLACK)
      square = Square.at(7, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(6, 0)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(5, 0))
    end

    def test_white_rook_cannot_move_left_through_black_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 7)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(0, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(0, 5))
    end

    def test_black_rook_cannot_move_left_through_white_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 7)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(0, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(0, 5))
    end

    def test_white_rook_cannot_move_right_through_black_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(0, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(0, 2))
    end

    def test_black_rook_cannot_move_right_through_white_piece
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(0, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(0, 2))
    end

    def test_white_rook_can_take_black_piece_up
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(1, 0)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_black_rook_can_take_white_piece_up
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(1, 0)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_white_rook_can_take_black_piece_down
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(7, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(6, 0)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_black_rook_can_take_white_piece_down
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::BLACK)
      square = Square.at(7, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(6, 0)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_white_rook_can_take_black_piece_left
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 7)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(0, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_black_rook_can_take_white_piece_left
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 7)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(0, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_white_rook_can_take_black_piece_right
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::WHITE)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(0, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_black_rook_can_take_white_piece_right
      # Arrange
      board = Board.empty

      rook = Rook.new(Player::BLACK)
      square = Square.at(0, 0)
      board.set_piece(square, rook)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(0, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end
  end

  class TestQueen < Minitest::Test

  end

end
