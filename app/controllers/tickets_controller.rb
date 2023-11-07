class TicketsController < ApplicationController
  def show
    @ticket = Ticket.find(params[:id])
  end
  def search
    @tickets = Ticket.where("movie_name like :movie_name", movie_name: "%#{params[:w]}%").where("status = 'on'")
    .order("id desc").page(params[:page] || 1).per(params[:per_page] || 12)
    .includes(:main_ticket_image)

    render template: 'welcome/index'
  end
end
