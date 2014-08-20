class PeopleController < ApplicationController
  protect_from_forgery

  def index
    @people = Person.all
  end

  def destroy
    Person.find(params[:id]).destroy

    redirect_to people_path
  end

  def import
    Person.parse(params[:csv])
  end

  def export_blanks
    respond_to do |format|
      pdf = BadgePdf.new([], {blanks: Person.all.count * 0.15})
      send_data pdf.render, filename: blank_badges.pdf, type: 'application/pdf', disposition: 'inline'
    end
  end

  def export
    respond_to do |format|
      format.pdf do
        pdf = BadgePdf.new(Person.all)
        send_data pdf.render, filename: 'badges.pdf', type: 'application/pdf', disposition: 'inline'
      end
      format.html
    end
  end
end
