class GameTasksController < ApplicationController
  before_action :set_game_task, only: %i[show edit answer update destroy]
  before_action :set_route

  def index
    @game_tasks = GameTask.all
  end

  def show
    if @game_task.state == 'planning'
      @game_task.start
    elsif @game_task.state == 'hint'
      @game_task.arrived

      @answers = @game_task.answers['answers'] if @game_task.multiple_choice?

    else
      @game_task.completed
    end
  end

  def answer
    if @game_task.photo_upload?
      @game_task.images.attach(params[:images])
    else
      answer = { current_or_guest_user.player.id => params[:answers] }
      @game_task.answers = if @game_task.answers.nil?
                             answer
                           else
                             @game_task.answers.merge(answer)
                           end
    end

    @game_task.save!
    @game_task.completed

    @game_task = @route.next_task(@game_task)

    if @game_task.nil?
      @route.end
      redirect_to route_path(@route)
    else
      redirect_to route_game_task_path(@route, @game_task)
    end
  end

  def new
    @player = current_or_guest_user.player
    @game_task = @route.player.game_tasks.new
    @game_task.type = params[:type]
  end

  def edit
    @type = @game_task
    @game_task = @game_task.becomes(GameTask)

    @tasks = ['latitude' => @game_task.latitude, 'longitude' => @game_task.longitude]
  end

  def create
    @player = current_or_guest_user.player
    @game_task = @player.game_tasks.new
    @game_task.latitude = 0.0
    @game_task.longitude = 0.0

    @game_task.route_id = @route.id
    @game_task.type = params[:type]

    if @game_task.save
      Rails.logger.warn('create was ok')
      redirect_to edit_route_game_task_path(@route, @game_task)
    else
      Rails.logger.warn('not ok')
      @game_task.errors.full_messages.each do |message|
        Rails.logger.warn(message)
      end
    end

    # results = Geocoder.search([@game_task.latitude, @game_task.longitude])
    # @game_task.location = results.first.address

    # respond_to do |format|
    #   if @game_task.save
    #     format.html { redirect_to route_path(@game_task.route_id), notice: 'Game task was successfully created.' }
    #     format.json { render :show, status: :created, location: @game_task }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @game_task.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
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

  def destroy
    @game_task.destroy
    respond_to do |format|
      format.html { redirect_to route_path(@route), notice: 'Game task was successfully destroyed.' }
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
    params.require(:game_task).permit(:id, :name, :type, :solution, :answers, :description, :hint, :latitude,
                                      :longitude, images: [])
  end
end
