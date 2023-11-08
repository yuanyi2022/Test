FactoryBot.define do
  factory :order do
    # 定义创建 ticket 需要的属性
    #  create_table "orders", force: :cascade do |t|
    #     t.integer "user_id"
    #     t.string "user_uuid"
    #     t.integer "ticket_id"
    #     t.integer "stock"
    #     t.datetime "created_at", null: false
    #     t.datetime "updated_at", null: false
    #     t.index ["user_id"], name: "index_orders_on_user_id"
    #     t.index ["user_uuid"], name: "index_orders_on_user_uuid"
    #   end
    user_id { 1 }
    user_uuid { SecureRandom.uuid }
    ticket_id { 1 }
    stock { 10 }
  end
end
