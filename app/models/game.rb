class Game < ApplicationRecord
  belongs_to :white_player, class_name: 'User'
  belongs_to :black_player, class_name: 'User', optional: true

  has_many :pieces, dependent: :destroy

  scope :available, -> { where('white_player_id IS NULL OR black_player_id IS NULL') }
  scope :ongoing, -> { where.not('white_player_id IS NULL OR black_player_id IS NULL') }
  scope :completed, -> { where.not(state: IN_PROGRESS) }
  

  validates :name, :presence => true

  def populate_board!
    
    1.upto(8).each do |i|
      Pawn.create(game_id: id, is_white: true, x_position: i, y_position: 2)
    end

    Rook.create(game_id: id, is_white: true, x_position: 1, y_position: 1)
    Rook.create(game_id: id, is_white: true,  x_position: 8, y_position: 1)

    Knight.create(game_id: id, is_white: true,  x_position: 2, y_position: 1)
    Knight.create(game_id: id, is_white: true,  x_position: 7, y_position: 1)

    Bishop.create(game_id: id, is_white: true, x_position: 3, y_position: 1)
    Bishop.create(game_id: id, is_white: true, x_position: 6, y_position: 1)

    King.create(game_id: id, is_white: true, x_position: 4, y_position: 1)
    Queen.create(game_id: id, is_white: true, x_position: 5, y_position: 1)

    #Black Player#
    1.upto(8).each do |i|
      Pawn.create(game_id: id, is_white: false, x_position: i, y_position: 7)
    end

    Rook.create(game_id: id, is_white: false, x_position: 1, y_position: 8)
    Rook.create(game_id: id, is_white: false, x_position: 8, y_position: 8)

    Knight.create(game_id: id, is_white: false, x_position: 2, y_position: 8)
    Knight.create(game_id: id, is_white: false, x_position: 7, y_position: 8)

    Bishop.create(game_id: id, is_white: false, x_position: 3, y_position: 8)
    Bishop.create(game_id: id, is_white: false, x_position: 6, y_position: 8)

    King.create(game_id: id, is_white: false, x_position: 5, y_position: 8)
    Queen.create(game_id: id, is_white: false, x_position: 4, y_position: 8)
  end

  def render_piece(x_pos, y_pos)
    piece = get_piece_at_coor(x_pos, y_pos)
    piece.render if piece.present?
  end

  def get_piece_at_coor(x_pos, y_pos)
    pieces.find_by(x_position: x_pos, y_position: y_pos)
  end

  def enemy_king(is_white)
    pieces.find_by(type: KING, is_white: !is_white)
  end

  def friendly_king(is_white)
    pieces.find_by(type: KING, is_white: is_white)
  end

  def attacking_piece(is_white)
    pieces.where(is_white: !is_white).where.not(x_position: nil, y_position: nil).find_each do |piece|
      return piece if piece.valid_move?(friendly_king(is_white).x_position, friendly_king(is_white).y_position)
    end
  end

  def under_attack?(is_white, x_pos, y_pos)
    pieces.where.not(is_white: is_white, x_position: nil).find_each do |piece|
      return true if piece.valid_move?(x_pos, y_pos)
      return true if piece.type == PAWN && piece.can_attack_square?(x_pos, y_pos)
    end
    false
  end
    
  def check?(is_white)
    under_attack?(is_white, friendly_king(is_white).x_position, friendly_king(is_white).y_position)
  end

  def checkmate?(is_white)
    return false unless check?(is_white)
    # return false if the piece attacking the king is also under attack / can be captured.
    return false if under_attack?(attacking_piece(is_white).is_white, attacking_piece(is_white).x_position, attacking_piece(is_white).y_position)
    # currently only the method can_move_out_of_check? is not working correctly.
    return false if friendly_king(is_white).can_move_out_of_check?
    return false if attacking_piece(is_white).can_be_blocked?(friendly_king(is_white).x_position, friendly_king(is_white).y_position)
    update!(player_win: black_player_id, player_lose: white_player_id) if is_white == true
    update!(player_win: white_player_id, player_lose: black_player_id) if is_white == false
    true
  end

  def forfeit(current_user)
    if current_user.id == white_player_id
      update!(player_win: black_player_id, player_lose: white_player_id)
    elsif current_user.id == black_player_id
      update!(player_win: white_player_id, player_lose: black_player_id)
    end
  end

  def stalemate?(is_white)
    return false if check?(is_white)
    king = pieces.find_by(is_white: is_white, type: KING)
    (1..8).each do |new_x|
      (1..8).each do |new_y|
        pieces.where(is_white: is_white).where.not(x_position: nil, y_position: nil, type: KING).find_each do |piece|
          return false if piece.legal_move?(new_x, new_y)
        end
        return true if king.legal_move?(new_x, new_y) && under_attack?(is_white, new_x, new_y)
      end
    end
    true
  end

  

  #logic relating to state 
  IN_PROGRESS = 0
  FORFEIT = 1
  CHECKMATE = 2
  STALEMATE = 3
  DRAW = 4


end
