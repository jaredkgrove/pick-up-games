class PlayersController < ApplicationController
    def show
        #@player = Player.find(:id)
    end

    def new

    end

    def create
        player = Player.new(player_params) 
        if !player.valid? || params[:player][:password] != params[:player][:password_confirmation]
            render :new
        else
            player.save
            session[:player_id] = player.id
            redirect_to root_path
        end
    end

    private
    def player_params
        params.require(:player).permit(:name, :password, :password_confirmation)
    end
end
