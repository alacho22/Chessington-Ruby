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
        if @player == Player::WHITE
          valid_moves << Square.at(current_row + 1, current_column)
        else
          valid_moves << Square.at(current_row - 1, current_column)
        end
        if @n_moves == 0
          if @player == Player::WHITE
            valid_moves << Square.at(current_row + 2, current_column)
          else
            valid_moves << Square.at(current_row - 2, current_column)
          end
        end
        valid_moves
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

    ##
    # A class representing a chess bishop.
    class Bishop
      include Piece

      def available_moves(board)
        []
      end
    end

    ##
    # A class representing a chess rook.
    class Rook
      include Piece

      def available_moves(board)
        []
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
