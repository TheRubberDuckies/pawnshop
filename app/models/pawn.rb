class Pawn < Piece
  def valid_move?(new_x, new_y)
    # return false if still_in_starting_square?(new_x.to_i, new_y.to_i)
    return false if backwards_move?(new_y.to_i)
    return false if sideways_move?(new_x.to_i, new_y.to_i)
    # return false if is_obstructed?(new_x.to_i, new_y.to_i)
    return false if square_occupied?(new_x.to_i, new_y.to_i) && forwards_straight_move?(new_x.to_i, new_y.to_i)
    return true if pawn_capture?(new_x.to_i, new_y.to_i)
    if move_two_squares_ok?(new_x.to_i, new_y.to_i) && !square_occupied?(new_x.to_i, new_y.to_i)
      update(turn_pawn_moved_twice: game.move_number + 1) if moving_two_squares?(new_x.to_i, new_y.to_i)
      return true
    end
  end

  def can_attack_square?(new_x, new_y)
    x_difference = (new_x.to_i - x_position.to_i).abs
    y_difference = (new_y.to_i - y_position.to_i).abs
    return true if x_difference == 1 && y_difference == 1
    false
  end

  # PAWN PROMOTION
  # checks to see if a pawn is promotable.
  def promotable?(_new_x, _new_y)
    true
  end

  # performs the pawn promotion by checking to see if the pawn meets the necessary requirements.
  def promote!(_new_x, _new_y)
    true
  end

  private

  def pawn_capture?(new_x, new_y)
    x_difference = (new_x.to_i - x_position.to_i).abs
    y_difference = (new_y.to_i - y_position.to_i).abs
    piece_to_capture = Piece.exists?(x_position: new_x, y_position: new_y, is_white: !is_white, game: game)
    return true if piece_to_capture && x_difference == 1 && y_difference == 1
    false
  end

  def forwards_straight_move?(new_x, new_y)
    return false if new_x != x_position
    return new_y > y_position if is_white
    new_y < y_position
  end

  def current_position?(new_x, new_y)
    x_position == new_x && y_position == new_y
  end

  def sideways_move?(new_x, new_y)
    x_difference = (x_position - new_x).abs
    x_difference != 0 && new_y == y_position
  end

  def backwards_move?(new_y)
    return new_y < y_position if is_white
    new_y > y_position
  end

  def move_two_squares_ok?(new_x, new_y)
    x_difference = (new_x.to_i - x_position.to_i).abs
    y_difference = (new_y.to_i - y_position.to_i).abs
    if piece_moved?
      x_difference.zero? && y_difference == 1
      # only allowed to move one space if pawn has already moved
    else
      x_difference.zero? && y_difference == 1 || x_difference.zero? && y_difference == 2

      end
    end
    end
