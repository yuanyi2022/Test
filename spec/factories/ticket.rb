FactoryBot.define do
  factory :ticket do
    # 定义创建 ticket 需要的属性
    #   create_table "tickets", force: :cascade do |t|
    #     t.string "movie_name"
    #     t.datetime "show_time"
    #     t.integer "duration"
    #     t.integer "stock"
    #     t.integer "price"
    #     t.string "status"
    #     t.string "uuid"
    #     t.text "description"
    #     t.datetime "created_at", null: false
    #     t.datetime "updated_at", null: false
    #   end
    movie_name { "ToDay" }
    show_time { "2020-03-10 15:00:00" }
    duration { 3600 }
    stock { 10 }
    price { 100 }
    status { "on" }
    uuid { SecureRandom.uuid}
    description { "MyText" }

  end
end
