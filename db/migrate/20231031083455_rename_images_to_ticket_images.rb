class RenameImagesToTicketImages < ActiveRecord::Migration[6.0]
  def change
    rename_table :images, :ticket_images
  end
end
