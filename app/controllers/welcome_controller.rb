class WelcomeController < ApplicationController

  def index
    @tickets = Ticket.onshelf.page(params[:page] || 1).per(params[:per_page] || 12)
    .order("id desc").includes(:main_ticket_image)
  end

end
