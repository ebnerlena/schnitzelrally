# frozen_string_literal: true

class RoutesController < ApplicationController
  before_action :set_route, only: %i[show edit map start add_task results update destroy]

  def index
    @player = current_or_guest_user.player
  end

  def show
    @which = 'Tasks'
    @player = current_or_guest_user.player
    @tasks = @route.game_tasks.where(player: @player)
  end

  def new
    @route = Route.new
  end

  def join
    if params[:name].nil?
      @route = Route.last
      render '_form_join'
    else
      @user = current_or_guest_user
      @user.name = params[:name]

      ok = @user.save
      if !ok
        redirect_to routes_path, notice: 'Not a valid username'
      else
        @route = Route.last
        render '_form_join'
      end
    end
  end

  def join_route
    @route = Route.where(name: params[:name], game_state: 'planning').first
    @player = current_or_guest_user.player

    if !@route.nil?
      @player.planning
      RoutesPlayersAssociation.create(player: @player, route: @route)
      redirect_to @route
    else
      Rails.logger.warn('route is nil')
    end
  end

  def add_task
    @which = 'Add Task'
    render '_add_task'
  end

  def map
    @which = 'Map'
    @player = current_or_guest_user.player

    @tasks = []
    @route.game_tasks.where(player: @player).each do |task|
      @tasks += ['latitude' => task.latitude, 'longitude' => task.longitude]
    end

    if @route.all_players_ready?
      RouteAllReadyJob.perform_later(@route, true)
    else
      RouteAllReadyJob.perform_later(@route, false)
    end

    render '_map', locals: { game_task: @game_task, route: @route, tasks: @tasks }
  end

  def start
    @route.start
    @player = @route.player
    @task = @route.current_task
    @player.route_start
    RouteStartJob.perform_later(@route, @task)
    redirect_to route_game_task_path(@route, @route.current_task)
  end

  def edit; end

  def create
    @player = current_or_guest_user.player
    @route = Route.new(route_params)
    @route.player_id = @player.id

    respond_to do |format|
      if @route.save
        @player.planning
        RoutesPlayersAssociation.create(player: @player, route: @route)
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render :show, status: :created, location: @route }
      else
        format.html { render :new }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to routes_url, notice: 'Route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:id, :name, :latitude, :longitude, :radius)
  end
end
