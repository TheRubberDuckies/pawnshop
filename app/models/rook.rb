class Rook < Piece

  def valid_rook_move?(new_x, new_y)
    own_piece_at_destination?(new_x, new_y) &&
    !is_obstructed?(new_x, new_y) &&
    ((y_position == new_y) && (x_position != new_x) || (x_position == new_x) && (y_position !=new_y)) 
  end
  
  def valid_move?(new_x, new_y)
    #If valid_move in piece.rb and valid_king_move true, then valid_move in
    #king.rb is true
    super(new_x, new_y) && valid_rook_move?(new_x, new_y)
  end

end
    

  
