class Knight < Piece

	def valid_move?(new_x, new_y)
	  return false if square_occupied?(new_y, new_y)
	  return true if 
	  	(x_position - new_x.to_i).abs == 1 && (y_position - new_y.to_i).abs == 2 ||
	  	(x_position - new_x.to_i).abs == 2 && (y_position - new_y.to_i).abs == 1  
	end 
	  false 
	def is_obstructed?(new_x, new_y); end 
end
	  



		
  


 
