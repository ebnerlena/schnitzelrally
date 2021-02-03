class RoutesController < ApplicationController
  before_action :set_route, only: %i[show edit map start update destroy]

  # GET /routes
  # GET /routes.json
  def index
    @player = current_or_guest_user.player
    
    # ActionCable.server.broadcast("Z2lkOi8vcHJvdG90eXBlMDEvUm91dGUvNw", body: "This Room is Best Room.")
    # RouteChannel.broadcast_to(@route, "hiiii")
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @which = 'Tasks'
    @player = current_or_guest_user.player
    @tasks = @route.game_tasks.where(player: @player)
    render '_tasks'
  end

  # GET /routes/new
  def new
    @route = Route.new
  end

  def join
    Rails.logger.warn(" Player name #{params[:name]}")

    if params[:name].nil?
      @route = Route.last
      render '_form_join'
    else
      @user = current_or_guest_user
      @user.name = params[:name]

      ok = @user.save
      if ! ok
        @user.errors.full_messages.each do |m|
          Rails.logger.warn(m)
        end
        redirect_to routes_path, notice: 'Not a valid username'
      else
        @route = Route.last
        render '_form_join'
      end
    end
  end

  def join_route
    @route = Route.where(name: params[:name], game_state: "planning").first
    
    if @route != nil
      @route.players.push(current_or_guest_user.player)
      redirect_to @route
    else
      Rails.logger.warn("route is nil")
      # render 'join'
    end
  end

  def map
    @which = 'Map'
    @player = current_or_guest_user.player
    
    @tasks = []
    @route.game_tasks.where(player: @player).each do |task|
      @tasks += ["latitude" => task.latitude, "longitude" => task.longitude]
    end

    render '_map'
  end

  def start
    @route.start
    @player = @route.player
    @tasks = @route.game_tasks.where(player: @player)
    redirect_to route_game_task_path(@route, @route.current_task)
  end

  # GET /routes/1/edit
  def edit; end

  # POST /routes
  # POST /routes.json
  def create
    
    @player = current_or_guest_user.player
    @route = @player.routes.create(route_params)
    
    results = Geocoder.search([@route.latitude, @route.longitude])
    @route.location = results.first.address
    
    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render :show, status: :created, location: @route }
      else
        format.html { render :new }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    @user = current_or_guest_user
    @route = Route.find(params[:id])
    @route.users.push(@user.player)

    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to @route, notice: 'Joined Route successfully' }
        format.json { render :show, status: :ok, location: @route }
      else
        format.html { render :edit }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to routes_url, notice: 'Route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_route
    @route = Route.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def route_params
    params.require(:route).permit(:id, :name, :latitude, :longitude, :radius)
  end
end
