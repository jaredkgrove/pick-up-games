class GamesController < ApplicationController
    before_action :require_login
    def show
        @game = Game.find(params[:id])
    end

    def create
        #require_login
        game = current_player.create_game_from_hash(game_params)
        @court = game.court
        if game.valid?
            redirect_to court_game_path(@court, game)
        else
            render "courts/show"
        end
    end

    def update
        game = Game.find(params[:id])
        if current_player.is_admin_of?(game)

        else
            
        end
    end

    private
    def game_params
        params.require(:game).permit(:time, :court_id, :skill_level)
    end
end
