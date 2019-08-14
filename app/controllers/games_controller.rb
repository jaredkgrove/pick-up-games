class GamesController < ApplicationController
    def show
        @game = Game.find(params[:id])
    end

    def create
        redirect_if_not_logged_in
        #raise params.inspect
        game = current_player.create_game_from_hash(game_params)
        redirect_to court_game_path(game.court, game)
    end

    private
    def game_params
        params.require(:game).permit(:time, :court_id)
    end
end
