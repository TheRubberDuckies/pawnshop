class King < Piece

	def valid_move?(new_x, new_y)
    	x_difference = (new_x.to_i - x_position).abs
    	y_difference = (new_y.to_i - y_position).abs
    	(x_difference <= 1) && (y_difference <= 1)
  	end
  
  def valid_move_check(new_x, new_y)
    if (off_board? super(new_x, new_y) && valid_move?(new_x, new_y))
      puts "The move is valid"
    else
      puts "The move is not valid"
    end
  end

end
    	
