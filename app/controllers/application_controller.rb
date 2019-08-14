class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def redirect_if_not_logged_in
        redirect_to root_path if !logged_in?
    end

    def logged_in?
        !!current_player
    end

    def current_player
        @current_player ||= Player.find(session[:player_id]) if session[:player_id]
    end

    helper_method :current_player
end
