module ApplicationHelper
    def player_admin_button(path:, text:, params_hash:)
        button_to text, path, :method => :patch, :params => params_hash
    end 
end
