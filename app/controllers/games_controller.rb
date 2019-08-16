class GamesController < ApplicationController
    before_action :require_login
    before_action :game_must_be_upcoming, only: [:show, :update]

    def show
        @game = Game.find(params[:id])
        redirect_to court_game_path(@game.court, @game) if params[:court_id] != @game.court.id.to_s
    end

    def create
        game = current_player.create_game_from_hash(game_params)
        @court = game.court
        if game.valid?
            redirect_to court_game_path(@court, game)
        else
            render "courts/show"
        end
    end

    def update
        raise params.inspect
        game = Game.find(params[:id])
        if current_player.is_admin_of?(game)
            
            if params[:player_id]
                player = Player.find(params[:player_id])
                game.add_or_remove_player(player)
            elsif params[:admin_id]
                player = Player.find(params[:admin_id])
                game.make_admin(player)
            elsif params[:squad_id]
               squad = Squad.find(params[:squad_id])
               game.add_squad_to_game(squad) 
            end
                redirect_to court_game_path(game.court, game)
        else
            game.add_or_remove_player(current_player)
            redirect_to court_game_path(game.court, game)
        end
    end

    private
    def game_params
        params.require(:game).permit(:time, :court_id, :skill_level)
    end

    def game_must_be_upcoming
        game = Game.find(params[:id])
        redirect_to root_path if game.time < Time.zone.now
    end
end
