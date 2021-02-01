class GameTasksController < ApplicationController
  before_action :set_game_task, only: %i[show edit update destroy]
  before_action :set_route

  # GET /game_tasks
  # GET /game_tasks.json
  def index
    @game_tasks = GameTask.all
  end

  # GET /game_tasks/1
  # GET /game_tasks/1.json
  def show
  end

  # GET /game_tasks/new
  def new
    # @player = Player.where(user_id: current_user.id, route_id: params[:route_id]).first
    
    # @game_task.player = @player
    # @player = current_player
    # @route = Route.find(params[:route_id])
    @player = Player.where(user_id: current_or_guest_user.id, route_id: @route.id).first
    @game_task = GameTask.new()
    @game_task.route_id = @route.id
    @game_task.player_id = @player.id
    # @game_task.route_id = @route.id
    # @game_task.player = @player
  end

  # GET /game_tasks/1/edit
  def edit;  end

  # POST /game_tasks
  # POST /game_tasks.json
  def create

    @game_task = GameTask.new(game_task_params)
    # @game_task.route_id = Route.last.id

    results = Geocoder.search([@game_task.latitude, @game_task.longitude])
    @game_task.location = results.first.address

    respond_to do |format|
      if @game_task.save
        format.html { redirect_to route_path(@game_task.route_id), notice: 'Game task was successfully created.' }
        format.json { render :show, status: :created, location: @game_task }
      else
        format.html { render :new }
        format.json { render json: @game_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_tasks/1
  # PATCH/PUT /game_tasks/1.json
  def update
    # Rails.logger.warn("ich will ein update machen #{game_task_params}")
    # @game_task.update(game_task_params)
    # Rails.logger.warn("aber die errors waren #{@game_task.errors}")
    # @game_task.errors.full_messages.each do |m|
    #   Rails.logger.warn(m)
    # end

    respond_to do |format|
      if @game_task.update(game_task_params)
        format.html { redirect_to route_path(@route), notice: 'Game task was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_task }
      else
        format.html { render :edit }
        format.json { render json: @game_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_tasks/1
  # DELETE /game_tasks/1.json
  def destroy
    @game_task.destroy
    respond_to do |format|
      format.html { redirect_to game_tasks_url, notice: 'Game task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game_task
    @game_task = GameTask.find(params[:id])
  end

  def set_route
    @route = Route.find(params[:route_id])
  end

  # Only allow a list of trusted parameters through.
  def game_task_params
    params.require(:game_task).permit(:id, :route_id, :player_id, :name, :description, :hint, :latitude, :longitude)
  end
end
