class SessionsController < ApplicationController
    def new
    end

    def create
        @player = Player.find_by(name: params[:player][:name])
        return head(:forbidden) unless @player.authenticate(params[:player][:password])
        session[:player_id] = @player.id
        redirect_to root_path
    end

    def destroy
        reset_session
        redirect_to root_path
    end
end
