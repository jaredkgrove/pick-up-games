class SquadsController < ApplicationController
    before_action :require_login

    def index
        @squads = Squad.all
        @squad = Squad.new
    end

    def show
        @squad = Squad.find(params[:id])
    end

    # def popular
    #     @popular_squads = Squad.popular_squads
    # end

    def create
        @squad = current_player.create_squad_from_hash(squad_params)
        if @squad.save
            set_flash_succes("Squad Successfully Created!")
            redirect_to squad_path(@squad)
        else
            @squads = Squad.all
            set_flash_errors(@squad)
            render :index
        end
    end

    def update
        squad = Squad.find(params[:id])
        if current_player.is_admin_of?(squad)
            if params[:player_id]
                player = Player.find(params[:player_id])
                squad.add_or_remove_player(player)
            else
                player = Player.find(params[:admin_id])
                squad.make_admin(player)
            end
        else
            squad.add_or_remove_player(current_player)
        end
        if Squad.find_by(id: squad.id)
            redirect_to(squad_path(squad)) 
        else
            set_flash_succes("Squad #{squad.name} Deleted")
            redirect_to(squads_path)
        end
    end

    private
    def squad_params
        params.require(:squad).permit(:name)
    end
end
