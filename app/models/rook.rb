class Rook < Piece
  
  def valid_move?(new_x, new_y)
    return false if is_obstructed?(new_x.to_i, new_y.to_i)
    return true if new_x.to_i == x_position || new_y.to_i == y_position
  end 
    false 
    
end 



    	
    


  
