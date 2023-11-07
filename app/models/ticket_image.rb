class TicketImage < ApplicationRecord
  belongs_to :ticket
  has_one_attached :image
  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                     size: { less_than: 5.megabytes, message: '大小超过5MB' }
end
