class Piece < ApplicationRecord


  belongs_to :game

	def color
    return 'white' if is_white == true
    'black'
  end

  def render
  	"#{color}-#{type.downcase}.png"
	end

  def move_to!(new_x, new_y)
    transaction do
      #if current_position?(new_x, new_y)
        #raise ArgumentError, 'That is an invalid move. Piece is still in starting square.'
      #end
      unless valid_move?(new_x, new_y)
        raise ArgumentError, "That is an invalid move for #{type}"
      end
      if square_occupied?(new_x, new_y)
        occupying_piece = game.get_piece_at_coor(new_x, new_y)
        raise ArgumentError, 'That is an invalid move. Cannot capture your own piece.' if (occupying_piece.is_white && is_white?) || (!occupying_piece.is_white && !is_white?)
        capture_piece!(occupying_piece)
      end
      update(x_position: new_x, y_position: new_y)
    end
  end



  def is_obstructed?(new_x, new_y)
    return false if type == KNIGHT
    return true if straight_obstruction?(new_x, new_y)
    false
  end 

  def vertical_move?(new_x, new_y)
    x_position == new_x && y_position != new_y
  end

  def horizontal_move?(new_x, new_y)
    (x_position != new_x) && (y_position == new_y)
  end 
  
  def diagonal_move?(new_x, new_y)
    (new_x.to_i - x_position.to_i).abs == (new_y.to_i - y_position.to_i).abs
  end 

  #covers vertical, horizontal, and diagonal moves 
  def straight_move?(new_x, new_y)
    (new_x.to_i - x_position.to_i != 0 || new_y.to_i - y_position.to_i != 0) &&
      (new_x.to_i == x_position.to_i || new_y.to_i == y_position.to_i || (new_x.to_i - x_position.to_i).abs == (new_y.to_i - y_position.to_i).abs
  end

  def straight_obstruction?(new_x, new_y)
    return false unless straight_move?(new_x, new_y)
    obstruction_array = straight_obstruction_array(new_x, new_y)
    obstruction_array.each do |coordinates|
    obstructing_piece = game.get_piece_at_coor(coordinates.first, coordinates.last)
      return true if obstructing_piece.present?
    end
    false
  end

  def coordinates_array(x_values, y_values)
    coordinates_array = x_values.zip(y_values)
    coordinates_array.shift
    coordinates_array.pop
    coordinates_array
  end

  def straight_obstruction_array(new_x, new_y)
    return nil unless straight_move?(new_x, new_y)
    x_values = if x_position.to_i < new_x.to_i
                 (x_position.to_i..new_x.to_i).to_a 
               elsif x_position.to_i > new_x.to_i
                 x_position.to_i.downto(new_x.to_i).to_a
               else 
                 range_y = (new_y.to_i - y_position.to_i).abs
                 Array.new(range_y + 1, new_x.to_i) 
               end

    y_values = if y_position.to_i < new_y.to_i
                 (y_position.to_i..new_y.to_i).to_a 
               elsif 
                  y_position.to_i > new_y.to_i
                  y_position.to_i.downto(new_y.to_i).to_a
               else 
                 range_x = (new_x.to_i - x_position.to_i).abs
                 Array.new(range_x + 1, new_y.to_i)
               end
    coordinates_array(x_values, y_values)
  end 

  def square_occupied?(new_x, new_y)
    piece = game.pieces.find_by(x_position: new_x, y_position: new_y)
    return false if piece.nil?
    true
  end

  def capture_piece!(captured_piece)
    captured_piece.update(x_position: nil, y_position: nil)
  end

  def current_position?(new_x, new_y)
    x_position == new_x && y_position == new_y
  end

  def increment_move
    game.update(move_number: game.move_number + 1)
    update(game_move_number: game.move_number, piece_move_number: piece_move_number + 1)
    update(piece_moved: true)
  end
end

PAWN = 'Pawn'.freeze
ROOK = 'Rook'.freeze
KNIGHT = 'Knight'.freeze
BISHOP = 'Bishop'.freeze
QUEEN = 'Queen'.freeze
KING = 'King'.freeze

    
      

      


  
      
        


