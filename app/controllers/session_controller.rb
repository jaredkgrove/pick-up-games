class SessionsController < ApplicationController
    def new
    end

    def create
        @player = Player.find_by(name: params[:player][:name])
        return head(:forbidden) unless @player.authenticate(params[:player][:password])
        session[:player_id] = @player.id
    end

    def destroy
        session.delete [:player_id]
    end
end
