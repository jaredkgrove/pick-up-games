class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception



    def logged_in?
        !!current_player
    end

    def current_player
        @current_player ||= Player.find(session[:player_id]) if session[:player_id]
    end

    helper_method :current_player

    def require_login
        redirect_to login_path if !logged_in?
    end
end
