class AddTicketImagesIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :ticket_images, [:ticket_id, :weight]
  end
end
