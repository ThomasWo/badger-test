class PeopleController < ApplicationController
  protect_from_forgery

  def index
    @people = Person.order(last_name: :asc, first_name: :asc)
  end

  def destroy
    Person.find(params[:id]).destroy

    redirect_to people_path
  end

  def import
    Person.parse(params[:csv], params[:role_id])
    render nothing: true
  end

  def export_blanks
    respond_to do |format|
      format.pdf do
        pdf = BadgePdf.new((1..4), {blanks: true})
        send_data pdf.render, filename: 'blank_badges.pdf', type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def export
    respond_to do |format|
      format.pdf do
        pdf = BadgePdf.new(Person.order(last_name: :asc, first_name: :asc))
        send_data pdf.render, filename: 'badges.pdf', type: 'application/pdf', disposition: 'inline'
      end
      format.html
    end
  end
end
