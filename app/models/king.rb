class King < Piece


	def valid_move?(new_x, new_y)
		return false if is_obstructed?(new_x.to_i, new_y.to_i)
  	return true if 
  		x_difference = (new_x.to_i - x_position).abs
    	y_difference = (new_y.to_i - y_position).abs
    	(x_difference <= 1) && (y_difference <= 1)
  end
  	false

  def can_move_out_of_check?
    ((x_position.to_i - 1)..(x_position.to_i + 1)).each do |x|
      next if x < 1 || x > 8
      ((y_position.to_i - 1)..(y_position.to_i + 1)).each do |y|
        next if y < 1 || y > 8
        return true if legal_move?(x, y) && !game.under_attack?(is_white, x, y)
      end
    end
    false
  end
end





    
    	
    
    	
