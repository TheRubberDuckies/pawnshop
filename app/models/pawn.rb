class Pawn < Piece

  def valid_move?(new_x, new_y)
    return false if is_obstructed?(new_x, new_y)
    return true if move_one_square?(new_x, new_y) || move_two_squares_ok?(new_x, new_y) 
    return true if can_pawn_attack?(new_x, new_y)
    false
  end
    
  private 

  def can_pawn_attack?(new_x, new_y)
    x_difference = (new_x - x_position).abs
    y_difference = (new_y - y_position).abs
    enemy_at_destination = Piece.exists?(x_position: new_x, y_position: new_y, is_white: !is_white, game: game)
    return true if enemy_at_destination && x_difference == 1 && y_difference == 1
    false
  end 

  def at_starting_position? 
    (is_white? && x_position == 2) || (!is_white && x_position == 7)
  end

  def move_one_square?(new_x, new_y) 
      (new_x.to_i - x_position.to_i).abs == 1 && (new_y.to_i == y_position.to_i) 
  end

  def move_two_squares_ok?(new_x, new_y)
    x_difference = (new_x.to_i - x_position.to_i).abs
    y_difference = (new_y.to_i - y_position.to_i).abs

    if type == PAWN && at_starting_position? 
    x_difference == 0 && y_difference == 1 || x_difference == 0 && y_difference == 2
    end 

  end 



end

      

