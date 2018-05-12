class PiecesController < ApplicationController

  def show
    @piece = Piece.find(params[:id])
    @game = @piece.game
  end

  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game 
    @piece.move_to!(params[:x_position], params[:y_position])
    redirect_to game_path(@game)
    @game.update(white_player_turn: !@game.white_player_turn)
    if @game.stalemate?(!@piece.is_white)
      @game.update(state: Game::STALEMATE)
      @game.update(white_player_turn: nil)
    end
    if @game.checkmate?(!@piece.is_white)
      @game.update(state: Game::CHECKMATE)
      @game.update(white_player_turn: nil)
    end
  rescue ArgumentError => e
    render json: { error: e.message }, status: :bad_request
  end

end 
  


  

  
  
    
    






