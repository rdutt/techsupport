class AddImageToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :image, :string
  end
end
