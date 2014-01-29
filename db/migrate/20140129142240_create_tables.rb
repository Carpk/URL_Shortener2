class CreateTables < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :shortened_url
      t.integer :click_counter
      t.integer :user_id
      t.timestamps
    end

    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.timestamps
    end
  end
end
