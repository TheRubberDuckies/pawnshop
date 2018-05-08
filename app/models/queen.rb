class Queen < Piece

		#Nikko version of valid_move?
	  def valid_queen_move(new_x, new_y)
	    vertical_move = self.x_position === new_x && self.y_position != new_y
	    horizontal_move = self.y_position === new_y && self.x_position != new_x
	  end

		#Linh version of valid_move?
	  def valid_move?(new_x, new_y)
	    return false if !super(new_x, new_y)
	    horizontal_move?(new_x, new_y) ||  vertical_move?(new_x, new_y) ||  diagonal_move?(new_x, new_y)
	  end 

end

