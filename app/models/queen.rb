class Queen < Piece
	
	def valid_move?(new_x, new_y)
    #If valid_move in piece.rb and valid_king_move true, then valid_move in
    #king.rb is true
    super(new_x, new_y) && valid_queen_move?(new_x, new_y)
  end

  def valid_queen_move?(new_x, new_y)
  	return false if is_obstructed?(new_x.to_i, new_y.to_i)
    return true if (new_x.to_i - x_position).abs == (new_y.to_i - y_position).abs || new_x.to_i == x_position || new_y.to_i == y_position
  end
  	false
end
