class SessionsController < ApplicationController
    def new
    end

    def create
        if auth_hash = request.env["omniauth.auth"]
            raise auth_hash.inspect
        else
            @player = Player.find_by(email: params[:player][:email])
            if @player && @player.authenticate(params[:player][:password])
                session[player_id] = @player.id
                redirect_to root_path
            else
                render :new
            end
        end
    end

    def destroy
        reset_session
        redirect_to root_path
    end
end
