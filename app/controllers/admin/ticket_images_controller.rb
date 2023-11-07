class Admin::TicketImagesController < Admin::BaseController
  before_action :find_ticket
  def index
    @ticket_images = @ticket.ticket_images
  end

  def create
    params[:ticket_images].each do |image|
      @ticket.ticket_images << TicketImage.new(image: image)
    end

    redirect_back(fallback_location: root_path)
  end


  def destroy
    @ticket_image = @ticket.ticket_images.find(params[:id])
    if @ticket_image.destroy
      flash[:notice] = "删除成功"
    else
      flash[:notice] = "删除失败"
    end
    redirect_back(fallback_location: root_path)
  end
  def update
    @ticket_image = @ticket.ticket_images.find(params[:id])
    @ticket_image.weight = params[:weight]
    if @ticket_image.save
      flash[:notice] = "修改成功"
    else
      flash[:notice] = "修改失败"
    end

    redirect_back(fallback_location: root_path)
  end
    private

  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end
