class AddUserUuidColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uuid, :string

    add_index :users, [:uuid], unique:true
    User.find_each do |user|
      user.uuid = SecureRandom.uuid
      user.save!
    end
  end
end
