class King < Piece

	def valid_king_move?(new_x, new_y)
    	x_difference = (new_x.to_i - x_position).abs
    	y_difference = (new_y.to_i - y_position).abs
    	(x_difference <= 1) && (y_difference <= 1)
  	end
  
  def valid_move?(new_x, new_y)
    #If valid_move in piece.rb and valid_king_move true, then valid_move in
    #king.rb is true
    super(new_x, new_y) && valid_king_move?(new_x, new_y)
  end

end
    	
