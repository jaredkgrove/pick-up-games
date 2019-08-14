class SessionsController < ApplicationController
    def new
    end

    def create
        if auth_hash = request.env["omniauth.auth"]
            @player = Player.find_or_create_by_omniauth_hash(auth_hash)
            session[:player_id] = @player.id
            redirect_to root_path
        else
            @player = Player.find_by(email: params[:player][:email])
            if @player && @player.authenticate(params[:player][:password])
                session[:player_id] = @player.id
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
