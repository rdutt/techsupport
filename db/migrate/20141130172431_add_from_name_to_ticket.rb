class AddFromNameToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :from_name, :string
  end
end
