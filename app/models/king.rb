class King < Piece

	def valid_move?(new_x, new_y)
		return false if is_obstructed?(new_x.to_i, new_y.to_i)
		return true if
			x_difference = (new_x.to_i - x_position).abs
		y_difference = (new_y.to_i - y_position).abs
	return true if	(x_difference <= 1) && (y_difference <= 1)
	false
	end

	def castling_path_obstructed?(new_x, new_y)
	end 

	def leaves_castled_king_in_check?(new_x, new_y)
	end 

	def passes_through_check?(new_x, new_y)
	end 



end





