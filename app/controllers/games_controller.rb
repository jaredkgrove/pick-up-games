class GamesController < ApplicationController
    before_action :require_login
    before_action :game_must_be_upcoming, only: [:show, :update]

    def show
        @game = Game.find(params[:id])
        redirect_to court_game_path(@game.court, @game) if params[:court_id] != @game.court.id.to_s
    end

    def create

        @game = current_player.games.build(game_params)
        @court = @game.court
        
        if @game.save
            @game.make_admin(current_player)
            set_flash_succes("Game Successfully Created!")
            respond_to do |format|
               format.html { redirect_to court_game_path(@court, @game) }
               format.json { render json: @court, serializer: CompleteCourtSerializer, include: [:upcoming_games], status: 201}
            end
        else
            set_flash_errors(@game)
            render json: @court, serializer: CompleteCourtSerializer, include: [:upcoming_games]
        end

        #render json: @court, serializer: CompleteCourtSerializer, include: [:upcoming_games]
    end

    def update
        game = Game.find(params[:id])
        if params[:squad_id] 
            squad = Squad.find(params[:squad_id])
            game.add_squad_to_game(squad)
        elsif current_player.is_admin_of?(game)
            #change logic to prevent admin from being able to remove other admin or add players not already in game
            if params[:player_id]
                player = Player.find(params[:player_id])
                game.add_or_remove_player(player) if game.is_in_game?(player)
            elsif params[:admin_id]
                player = Player.find(params[:admin_id])
                game.make_admin(player) if game.is_in_game?(player) & !player.is_admin_of?(game)
            end
        else
            game.add_or_remove_player(current_player)
        end
        if Game.find_by(id: game.id)
            redirect_to court_game_path(game.court, game)
        else
            set_flash_succes("Game Deleted")
            redirect_to court_path(game.court)
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
