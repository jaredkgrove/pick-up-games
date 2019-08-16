class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def set_flash_errors(object)
        flash.now[:errors] = []
        object.errors.full_messages.each do |message|
            flash.now[:errors] << message
        end
    end

    def set_flash_succes(message)
        flash[:success] = [message]
    end

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
