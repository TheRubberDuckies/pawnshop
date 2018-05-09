class King < Piece


	def valid_move?(new_x, new_y)
		return false if is_obstructed?(new_x.to_i, new_y.to_i)
  	return true if 
  		x_difference = (new_x.to_i - x_position).abs
    	y_difference = (new_y.to_i - y_position).abs
    	(x_difference <= 1) && (y_difference <= 1)
  end
  	false
end 
  #still need to account for invalid move if King moves into check


KING = 'King'.freeze


    
    	
    
    	
