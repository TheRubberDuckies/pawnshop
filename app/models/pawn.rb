class Pawn < Piece


	def valid_move?(new_x, new_y)
    return false if is_obstructed?(new_x, new_y)
    return false if current_position?(new_x.to_i, new_y.to_i)
    return false if square_occupied?(new_x, new_y) 
    return true if can_attack_square?(new_x.to_i, new_y.to_i)
    return true if move_one_square?(new_x, new_y) || move_two_squares?(new_x, new_y)
    end
    false
  end
    
  def can_attack_square?(new_x, new_y)
    x_difference = (new_x.to_i - x_position.to_i).abs
    y_difference = (new_y.to_i - y_position.to_i).abs
    opponent_piece_in_square = Piece.exists?(x_position: new_x, y_position: new_y, is_white: !is_white)
      return true if opponent_piece_in_square && x_difference == 1 && y_difference == 1
    false
  end

  def at_starting_position? 
    (is_white? && x_position == 2) || (!is_white && x_position == 7)
  end

  def move_one_square?(new_x, new_y)
    if type == PAWN && !square_occupied?(new_x, new_y) 
      (new_x.to_i - x_position.to_i).abs == 1 &&
      (new_y.to_i - y_position.to_i).abs == 0
    end
  end

  def move_two_squares?(new_x, new_y)
    if type == PAWN && at_starting_position? && !square_occupied?(new_x, new_y) 
      (new_x.to_i - x_position.to_i).abs == 2 && 
      (new_y.to_i - y_position.to_i).abs == 0
  end 

end

      

