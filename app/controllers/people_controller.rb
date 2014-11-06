class PeopleController < ApplicationController
  protect_from_forgery

  before_action :get_event #, only: [:index, :destroy, :import]

  def index
    @people = @event.people
  end

  def destroy
    @event.people.find(params[:id]).destroy

    redirect_to event_people_path(@event)
  end

  def import
    @event.people.parse(params[:data], @event)
    render nothing: true
  end

  def export_blanks
    role = Role.find(params[:role_id])
    respond_to do |format|
      format.pdf do
        pdf = BadgePdf.new(@event, {blanks: true, role: role, num_badges: params[:num_badges].to_i})
        send_data pdf.render, filename: 'blank_badges.pdf', type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def export
    respond_to do |format|
      format.pdf do
        pdf = BadgePdf.new(@event)
        send_data pdf.render, filename: 'badges.pdf', type: 'application/pdf', disposition: 'inline'
      end
      format.html
    end
  end

  private

  def get_event
    @event = Event.find(params[:event_id])
  end
end
