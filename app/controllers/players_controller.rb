class PlayersController < ApplicationController
    def show
        @player = Player.find(params[:id])
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
