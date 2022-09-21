module Chessington
  module Engine
    ##
    # An abstract base class from which all pieces inherit.
    module Piece
      attr_reader :player

      def initialize(player)
        @player = player
        @n_moves = 0
      end

      ##
      #  Get all squares that the piece is allowed to move to.
      def available_moves(board)
        raise "Not implemented"
      end

      ##
      # Move this piece to the given square on the board.
      def move_to(board, new_square)
        board.move_piece(get_current_square(board), new_square)
        @n_moves += 1
      end

      def get_current_square(board)
        board.find_piece(self)
      end
    end

    ##
    # A class representing a chess pawn.
    class Pawn
      include Piece

      def available_moves(board)
        current_square = get_current_square(board)
        current_row = current_square.row
        current_column = current_square.column
        valid_moves = []

        row_one_forwards = destination_row_after_move(current_row, 1)
        one_forwards = Square.at(row_one_forwards, current_column)
        # can move forwards unless the space is occupied
        if board.in_board(one_forwards) && board.is_square_empty(one_forwards)
          valid_moves << one_forwards
          # can move two forwards if haven't moved yet
          two_forwards = Square.at(destination_row_after_move(current_row, 2), current_column)
          if board.in_board(two_forwards) && board.is_square_empty(two_forwards) && @n_moves == 0
            valid_moves << two_forwards
          end
        end
        # can move diagonally to take pieces
        one_diagonal_left = Square.at(row_one_forwards, current_column - 1)

        one_diagonal_right = Square.at(row_one_forwards, current_column + 1)

        opponent = @player.opponent

        if board.in_board(one_diagonal_left) && board.square_controlled_by(one_diagonal_left) == opponent
          one_diagonal_left_piece = board.get_piece(one_diagonal_left)
          unless one_diagonal_left_piece.is_a?(King)
            valid_moves << one_diagonal_left
          end
        end
        if board.in_board(one_diagonal_right) && board.square_controlled_by(one_diagonal_right) == opponent
          one_diagonal_right_piece = board.get_piece(one_diagonal_right)
          unless one_diagonal_right_piece.is_a?(King)
            valid_moves << one_diagonal_right
          end

        end

        valid_moves
      end

      def destination_row_after_move(current_row, n_spaces)
        if @player == Player::WHITE
          current_row + n_spaces
        else
          current_row - n_spaces
        end
      end
    end

    ##
    # A class representing a chess knight.
    class Knight
      include Piece

      def available_moves(board)
        []
      end
    end

    class AnyNumberMovementPiece
      include Piece

      def unit_move_directions
        raise "Not Implemented"
      end

      def available_moves(board)
        current_square = get_current_square(board)
        current_row = current_square.row
        current_column = current_square.column
        opponent = @player.opponent

        valid_moves = []

        unit_move_directions.each { |row_direction, col_direction|
          n_spaces_moved = 1
          loop do
            row = current_row + (row_direction * n_spaces_moved)
            col = current_column + (col_direction * n_spaces_moved)
            target_square = Square.at(row, col)

            unless board.in_board(target_square)
              break
            end

            occupying_piece = board.get_piece(target_square)
            if !occupying_piece.nil? && occupying_piece.player != opponent
              break
            end

            valid_moves << target_square
            n_spaces_moved += 1

            if !occupying_piece.nil? && occupying_piece.player == opponent
              break
            end

          end
        }
        valid_moves
      end

    end

    ##
    # A class representing a chess bishop.
    class Bishop < AnyNumberMovementPiece

      def unit_move_directions
        [[1, 1], [-1, 1], [1, -1], [-1, -1]]
      end


    end

    ##
    # A class representing a chess rook.
    class Rook < AnyNumberMovementPiece

      def unit_move_directions
        [[1, 0], [0, 1], [-1, 0], [0, -1]]
      end

    end

    ##
    # A class representing a chess queen.
    class Queen
      include Piece

      def available_moves(board)
        []
      end
    end

    ##
    # A class representing a chess king.
    class King
      include Piece

      def available_moves(board)
        []
      end
    end
  end
end
