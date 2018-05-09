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
      raise ArgumentError, "#{type} has not moved." unless real_move?(new_x, new_y)
      occupying_piece = game.get_piece_at_coor(new_x, new_y)
      raise ArgumentError, "That is an invalid move for #{type}" unless valid_move?(new_x, new_y) 
      raise ArgumentError, 'That is an invalid move. Cannot capture your own piece.' if same_color?(occupying_piece)
      capture_piece!(occupying_piece) if square_occupied?(new_x, new_y)
      update(x_position: new_x, y_position: new_y)
      raise ArgumentError, 'That is an invalid move that leaves your king in check.' 
      if game.under_attack?(is_white, game.your_king(is_white).x_position, game.your_king(is_white).y_position)
    end
  end

  def same_color? (occupying_piece)
    occupying_piece.present? && occupying_piece.color == color
  end

  def is_obstructed?(new_x, new_y)
    return false if type == KNIGHT
    return true if off_board?(new_x, new_y)
    return true if straight_obstruction?(new_x, new_y)
    false
  end 

  #covers vertical, horizontal, and diagonal moves 
  def straight_move?(new_x, new_y)
    (new_x.to_i - x_position.to_i != 0 || new_y.to_i - y_position.to_i != 0) &&
      (new_x == x_position || new_y == y_position || (new_x.to_i - x_position.to_i).abs == (new_y.to_i - y_position.to_i).abs)
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
               elsif y_position.to_i > new_y
                 y_position.to_i.downto(new_y.to_i).to_a
               else 
                 Array.new(range_x + 1, new_y.to_i)
               end
    coordinates_array(x_values, y_values)

  def square_occupied?(new_x, new_y)
    piece = game.pieces.find_by(x_position: new_x, y_position: new_y)
    return false if piece.nil?
    true
  end

  def off_board?(new_x, new_y)
      new_x < 1 || new_x > 8 || new_y < 1 || new_y > 8
  end

  def capture_piece!(captured_piece)
    captured_piece.update(x_position: nil, y_position: nil)
  end

  def real_move?(new_x, new_y)
    @piece = game.get_piece_at_coor(new_x, new_y)
    return true if @piece.nil?
    return false if @piece.id == id
    true
  end

  def count_moves
    game.update(move_number: game.move_number + 1)
    update(game_move_number: game.move_number, piece_move_number: piece_move_number + 1)
    update(has_moved: true)
  end


end

    
      

      


  
      
        


