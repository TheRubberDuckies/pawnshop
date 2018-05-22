class GamesController < ApplicationController
  before_action :authenticate_user!


  def index
    @available_games = Game.available
    @ongoing_games = Game.ongoing
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    @game.update_attributes(:white_player => current_user)
    @game.populate_board!
    redirect_to games_path

  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path

  end

  def show
    @game = Game.find(params[:id])
    white_player_name = @game.white_player.name
    black_player_name = @game.black_player.name
    white_player_turn = @game.white_player_turn
    game_state = @game.state
    

  end

  def update
    @game = Game.find(params[:id])
    if @game.black_player.nil?
      @game.update(black_player_id: current_user.id)
    else
      @game.update(white_player_id: current_user.id)
    end
    redirect_to game_path(@game)
  end

  def forfeit
    @game = Game.find(params[:id])
    @game.update(state: Game::FORFEIT, player_lose: current_user.id, white_player_turn: nil)
    redirect_to games_path, :notice => "Game Has Been Forfeited!"
  end

  private

  def game_params
      params.require(:game).permit(:name, :white_player, :black_player)
  end

  helper_method :current_game

  def current_game
    @current_game ||= Game.find(params[:id])
  end

end
