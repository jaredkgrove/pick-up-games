class PlayersController < ApplicationController
    before_action :require_login, only:[:current]
    def current
        @player = current_player ? current_player : Player.new
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @player}
        end
    end

    def show
        @player = Player.find(params[:id])
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @player, include: [:squads, :upcoming_games] }
        end
    end

    def new
        @player = Player.new
    end

    def create
        @player = Player.new(player_params) 
        if !@player.valid? || params[:player][:password] != params[:player][:password_confirmation]
            set_flash_errors(@player)
            render :new
        else
            @player.save
            session[:player_id] = @player.id
            redirect_to root_path
        end
    end

    private
    def player_params
        params.require(:player).permit(:email, :password, :password_confirmation, :name)
    end
end
