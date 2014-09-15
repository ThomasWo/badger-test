class RolesController < ApplicationController
  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @role = Role.create(level: params[:role][:level], display: params[:role][:display], event_id: params[:event_id])

    if @role.valid?
      flash[:status] = "Successfully added #{@role.level} to #{@role.event.name}"
      redirect_to event_path(params[:event_id])
    else
      flash[:error] = @role.errors.messages[:level][0]
      render :new
    end
  end
end
