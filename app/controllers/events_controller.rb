class EventsController < ApplicationController
  before_action :get_event, except: [:new, :create, :index]

  def index
    @events = Event.all

    respond_to do |format|
      format.html
    end
  end

  def show
    if params[:role_id]
      @role = Role.find(params[:role_id])
    else
      @role = Role.first
    end

    respond_to do |format|
      format.html
    end
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event, role_id: params[:role_id]), notice: "Event was updated successfully."
    else
      render 'show'
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
    def get_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :start_date, :end_date, :logo)
    end
end
