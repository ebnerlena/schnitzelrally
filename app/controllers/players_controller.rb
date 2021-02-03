class PlayersController < ApplicationController
  before_action :set_player, only: %i[show edit update destroy]
  
    def index
      @player = current_or_guest_user.player || current_or_guest_user.player.new()
      
    end

    def new
      @player = Player.new
    end

    def edit;
    end
   
    def create
      @user = current_or_guest_user
      @player = Player.create(player_params)
      @user.player = @player

      respond_to do |format|
        if @player.save
          format.html { redirect_to routes_path }
          format.json { render :show, status: :created, location: @player }
        else
          format.html { render :new }
          format.json { render json: @player.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def update
      respond_to do |format|
        if @player.update(player_params)
          format.html { redirect_to routes_path }
          format.json { render :show, status: :created, location: @player }
        else
          format.html { render :new }
          format.json { render json: @player.errors, status: :unprocessable_entity }
        end
      end
    end
     
    def destroy
      @player.destroy
      respond_to do |format|
        format.html { redirect_to routes_url }
        format.json { head :no_content }
      end
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:id, :name, :avatar)
    end
  end
  