# spec/factories/ticket_images.rb
FactoryBot.define do
  factory :ticket_image do
    ticket
    image { '~/image1.jpg' } # 根据实际情况调整
    weight { 1 }
  end
end