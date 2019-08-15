class GamesController < ApplicationController
    def show
        @game = Game.find(params[:id])
    end

    def create
        redirect_if_not_logged_in
        raise params.inspect
        game = current_player.create_game_from_hash(game_params)
        if game.valid?
            redirect_to court_game_path(game.court, game)
        else
            render courts_path(game.court)
        end
    end

    private
    def game_params
        params.require(:game).permit(:time, :court_id)
    end
end
