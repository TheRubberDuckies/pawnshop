class Piece < ApplicationRecord

  belongs_to :game

	def color
    return 'white' if is_white == true
    'black'
  end

  def render
  	"#{color}-#{type.downcase}.png"
	end

#Defines general valid moves which apply to all pieces
  def valid_move?(new_x, new_y)
    !off_board?(new_x, new_y)
  end
  
#Updated move_to in a cleaner way. But same idea that you created.
  def move_to!(new_x, new_y)
    transaction do
      raise ArgumentError, "#{type} has not moved." unless real_move?(new_x, new_y)
      occupying_piece = game.get_piece_at_coor(new_x, new_y)
      raise ArgumentError, 'That is an invalid move. Cannot capture your own piece.' if same_color?(occupying_piece)
      capture_piece!(occupying_piece) if square_occupied?(new_x, new_y)
      update(x_position: new_x, y_position: new_y)
    end
  end

  def square_occupied?(new_x, new_y)
      piece = game.pieces.find_by(x_position: new_x, y_position: new_y)
      #.present asking boolean
      piece.present?
  end

  def off_board?(new_x, new_y)
      new_x < 1 || new_x > 8 || new_y < 1 || new_y > 8
  end

#Created a method to separate occupying piece same color
  def same_color occupying_piece
    (occupying_piece.is_white && is_white?) || (!occupying_piece.is_white && !is_white?)
  end

  def real_move?(new_x, new_y)
    piece_found = game.get_piece_at_coor(new_x, new_y)
    return true if piece_found.nil?
    return false if piece_found.id == id
    true
  end
  
  def capture_piece!(captured_piece)
    captured_piece.update(x_position: nil, y_position: nil)
  end

  def count_moves
    game.update(move_number: game.move_number + 1)
    update(game_move_number: game.move_number, piece_move_number: piece_move_number + 1)
    update(has_moved: true)
  end
end
