class Ticket < ApplicationRecord
  validates :movie_name, presence: { message: "电影名称不能为空" }
  validates :show_time, presence: { message: "放映时间不能为空" }
  validates :duration, presence: { message: "时长不能为空" }
  validates :stock, numericality: { only_integer: true, message: "库存必须是整数" },
            if: proc { |ticket| ticket.price.blank? }
  validates :stock, presence: { message: "库存不能为空" }
  validates :price, numericality: {  message: "价格必须是数字" },
            if: proc { |ticket| ticket.price.blank? }
  validates :price, presence: { message: "价格不能为空" }
  validates :status, presence: { message: "状态不能为空" }
  validates :status, inclusion: { in: %w[on off], message: "状态必须是上架或下架" }
  validates :description, presence: { message: "描述不能为空" }
  before_create :set_uuid
  has_many :ticket_images, -> {order(weight: 'desc')}, dependent: :destroy
  has_one :main_ticket_image, -> { order(weight: 'desc') },
  class_name: 'TicketImage'
  scope :onshelf, -> {where(status: Status::On)}
  module Status
    On = 'on'
    Off = 'off'
  end
  def small_image
    ticket_images.first.image.variant(resize: "60x60^").processed if ticket_images.attached?
  end

  def middle_image
    ticket_images.first.variant(resize: "200x200^").processed if ticket_images.attached?
  end

  def big_image
    ticket_images.first.variant(resize: "960x").processed if ticket_images.attached?
  end
  private
  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
