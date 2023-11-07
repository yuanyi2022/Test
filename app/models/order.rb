class Order < ApplicationRecord
  validates :user_uuid, presence: true
  validates :ticket_id, presence: true
  validates :stock, presence: true
  belongs_to :ticket

  scope :by_user_uuid, ->(user_uuid) { where(user_uuid: user_uuid) }
  def self.create_or_update!(options = {})
    cond = {
      user_uuid: options[:user_uuid],
      ticket_id: options[:ticket_id]
    }
    record = where(cond).first
    if record
      record.update(options.merge(stock: record.stock + options[:stock]))
    else
      record = create(options)
    end
    record
  end
end
