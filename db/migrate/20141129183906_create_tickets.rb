class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :platform
      t.string :application
      t.string :member1
      t.string :member2
      t.text :error_message
      t.text :description
      t.string :priority
      t.string :from_email

      t.timestamps
    end
  end
end
