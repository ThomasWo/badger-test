class RolesController < ApplicationController
  before_action :get_event, only: [:new, :create, :show, :edit, :update, :destroy]

  def index
    @roles = Role.all
  end

  def new
    @role = @event.roles.build

    respond_to do |format|
      format.html
    end
  end

  def show
    @role = @event.roles.find(params[:id])
  end

  def edit
    @role = @event.roles.find(params[:id])
  end

  def update
    @role = @event.roles.find(params[:id])

    if @role.update_attributes(role_params)
      redirect_to event_path(@event), notice: "Successfully updated #{@role.level} to #{@event.name}."
    else
      flash[:error] = "Error updating role."
      render :edit
    end
  end

  def create
    @role = @event.roles.build(role_params)

    if @role.save
      redirect_to event_path(@event), notice: "Successfully added #{@role.level} to #{@event.name}."
    else
      flash[:error] = "Error creating role."
      render :new
    end
  end

  def destroy
    @role = @event.roles.find(params[:id])
    @role.destroy
    redirect_to event_path(@event), notice: "Successfully deleted #{@role.level} from #{@event.name}."
  end

  private
    def role_params
      params.require(:role).permit(:level, :display)
    end

    def get_event
      @event = Event.find(params[:event_id])
    end
end
