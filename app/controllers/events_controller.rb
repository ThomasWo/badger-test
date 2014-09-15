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
    start_date = []
    end_date = []

    (1..5).each do |i|
      start_date << params[:event]["start_date(#{i}i)"].to_i
      end_date << params[:event]["end_date(#{i}i)"].to_i
    end

    @event = Event.create(
      name: params[:event][:name],
      start_date: DateTime.civil_from_format(:local, start_date[0], start_date[1], start_date[2], start_date[3], start_date[4]),
      end_date: DateTime.civil_from_format(:local, end_date[0], end_date[1], end_date[2], end_date[3], end_date[4])
    )

    redirect_to @event
  end

  def import_image
    event = Event.find(params[:id])

    filename = Event.import_logo(params[:data], event.name)

    event.logo_path = filename
    event.save

    render nothing: true
  end
end
