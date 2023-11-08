# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    email { "aaa@brother.com" }
    password { "aaaaaa" }
    password_confirmation { "aaaaaa" }
    nickname { "aaa" }
    age { rand(18..65) }
    gender { ["male", "female"].sample }
    phone_number { "17000000000"}
    role { :user } # 默认是普通用户
    uuid { SecureRandom.uuid }
    # 其他用户属性...
  end

  factory :admin_user, parent: :user do
    role { :admin } # 设置用户为管理员
  end
end
