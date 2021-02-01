class RoutesController < ApplicationController
  before_action :set_route, only: %i[show edit map start update destroy]

  # GET /routes
  # GET /routes.json
  def index
    @routes = Route.all
    @route = Route.last
    ActionCable.server.broadcast("Z2lkOi8vcHJvdG90eXBlMDEvUm91dGUvNw", body: "This Room is Best Room.")
    RouteChannel.broadcast_to(@route, "hiiii")
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @which = 'Tasks'
    @player = @route.players.where(user_id: current_or_guest_user).first
    @tasks = @route.game_tasks.where(player_id: @player.id)
    render '_tasks'
  end

  # GET /routes/new
  def new
    @route = Route.new
    @player = Player.new
  end

  def join
    @route = Route.last
    render '_form_join'
  end

  def join_route
    @route = Route.where(game_id: params[:game_id]).first
    @route.join(current_or_guest_user, params[:playername])
    redirect_to @route, notice: 'Route was successfully created.'
  end

  def map
    @which = 'Map'
    @player = @route.players.where(user_id: current_or_guest_user).first
    @tasks = @route.game_tasks.where(player_id: @player.id)
    render '_map'
  end

  def start
    @route.start
    @player = @route.players.where(user_id: current_or_guest_user).first
    @tasks = @route.game_tasks.where(player_id: @player.id)
    render 'show'
  end

  # GET /routes/1/edit
  def edit; end

  # POST /routes
  # POST /routes.json
  def create
    @player = Player.new(name: "Owner", user_id: current_or_guest_user.id)

    # not working
    Rails.logger.warn("Player: #{params[:player_id]}")


    @route = Route.new(valid_route_params)
    ok = @route.save
    if ! ok 
      Rails.logger.warn("fehler bei route save!")
      @route.errors.full_messages.each do |m|
        Rails.logger.warn(m)
      end
    end
    
    @player.route_id=@route.id
    ok = @player.save
    if ! ok 
      Rails.logger.warn("fehler bei player save!")
      @player.errors.full_messages.each do |m|
        Rails.logger.warn(m)
      end
    end    
    
    @route.player_id = @player.id
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
    # gets used as join method now 

    @player = Player.where(user_id: current_or_guest_user.id)
    @route = Route.find(params[:id])
    @route.players.push(@player)

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
    params.require(:route).permit(:id, :player_id, :location, :game_id, :latitude, :longitude, :radius)
  end

  def valid_route_params
    params.require(:route).permit(:id, :location, :game_id, :latitude, :longitude, :radius)
  end
end
