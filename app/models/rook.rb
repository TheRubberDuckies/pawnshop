class Rook < Piece
  
  def valid_move?(new_x, new_y)
    return false if is_obstructed?(new_x.to_i, new_y.to_i) 
    return true if horizontal_move?(new_x.to_i, new_y.to_i)
    return true if vertical_move?(new_x.to_i, new_y.to_i)
    false
  end  

    
end 



    	
    


  
