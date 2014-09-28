class EventsController < ApplicationController
  def index
    @events = Event.all
    respond_to do |format|
      format.html
    end
  end

  def show
    @event = Event.find(params[:id])

    if params[:role_id]
      @role = Role.find(params[:role_id])
    else
      @role = Role.first
    end

    respond_to do |format|
      format.html
    end
  end

  def new
    @event = Event.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: "Event was created successfully."
    else
      flash[:error] = "Event could not be created."
      render 'new'
    end
  end

  private
    def event_params
      params.require(:event).permit(:name, :start_date, :end_date, :logo)
    end
end
