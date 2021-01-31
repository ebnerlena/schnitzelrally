class RoutesController < ApplicationController
  before_action :set_route, only: %i[show edit update destroy]

  # GET /routes
  # GET /routes.json
  def index
    @routes = Route.all
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @player = Player.last
  end

  # GET /routes/new
  def new
    @route = Route.new
  end

  def join
    @route = Route.last
    render '_form_join'
  end

  def join_route;  end

  # GET /routes/1/edit
  def edit; end

  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(route_params)
    @route.save
    
    @player = Player.new(name: "I am a new Player", user_id: current_user.id, route_id: @route.id)
    @player.save
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
    params.require(:route).permit(:id, :latitude, :longitude, :radius, :start_time,
                                  :end_time)
  end
end
