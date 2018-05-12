class Pawn < Piece

  def valid_move?(new_x, new_y)
    return false if is_obstructed?(new_x, new_y)
    return false if still_at_starting_position?(new_x.to_i, new_y.to_i)
    return true if capture_move?(new_x.to_i, new_y.to_i)
    return true if en_passant_capture?(new_x.to_i, new_y.to_i)
    if allowed_to_move?(new_x.to_i, new_y.to_i) && !square_occupied?(new_x.to_i, new_y.to_i)
      update(pawn_moved_twice: game.move_number + 1) if moving_two_squares?(new_x.to_i, new_y.to_i)
      return true
    end
    false
  end

  def can_attack_square?(new_x, new_y)
    x_difference = (new_x.to_i - x_position.to_i).abs
    y_difference = (new_y.to_i - y_position.to_i).abs
    return true if x_difference == 1 && y_difference == 1
    false
  end
    
  private 

  def capture_move?(new_x, new_y)
    x_difference = (new_x.to_i - x_position.to_i).abs
    y_difference = (new_y.to_i - y_position.to_i).abs
    enemy_in_dest = Piece.exists?(x_position: new_x, y_position: new_y, is_white: !is_white, game: game)
    return true if enemy_in_dest && x_difference == 1 && y_difference == 1
    false
  end

  def en_passant_capture?(new_x, new_y)
    adjacent_enemy_pawn = Pawn.find_by(x_position: new_x, y_position: y_position, is_white: !is_white, game: game)
    return false if adjacent_enemy_pawn.nil?
    if adjacent_enemy_pawn.vul_to_en_passant? && !square_occupied?(new_x, new_y)
      capture_piece(adjacent_enemy_pawn)
      return true
    end
    false
  end

  def still_at_starting_position?(new_x, new_y) 
    (is_white? && x_position == 2) || (!is_white && x_position == 7)
  end

  def moving_two_squares?(new_x, new_y)
    x_difference = (new_x.to_i - x_position.to_i).abs
    y_difference = (new_y.to_i - y_position.to_i).abs
    x_difference.zero? && y_difference == 2
  end

  def allowed_to_move?(new_x, new_y)
    x_difference = (new_x.to_i - x_position.to_i).abs
    y_difference = (new_y.to_i - y_position.to_i).abs
    if piece_moved
      x_difference.zero? && y_difference == 1
    else
      x_difference.zero? && y_difference == 1 || x_difference.zero? && y_difference == 2
    end
  end

end

      

