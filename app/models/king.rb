class King < Piece


	def valid_move?(new_x, new_y)
		#return false if is_obstructed?(new_x.to_i, new_y.to_i)
  	return true if
  		x_difference = (new_x.to_i - x_position).abs
    	y_difference = (new_y.to_i - y_position).abs
    	(x_difference <= 1) && (y_difference <= 1)
  end
  	false
end

	# determine if king can move himself out of check
 def can_move_out_of_check?
	 start_x = x_position
	 start_y = y_position
	 success = false
	 ((x_position - 1)..(x_position + 1)).each do |x|
		 ((y_position - 1)..(y_position + 1)).each do |y|
			 update_attributes(x_position: x, y_position: y) if valid_move?(x, y)
			 # if game.check?(color) comes up false,
			 # even once, assign  true
			 success = true unless game.check?(color)
			 # reset any attempted moves
			 update_attributes(x_position: start_x, y_position: start_y)
		 end
	 end
	 success
 end


KING = 'King'.freeze
