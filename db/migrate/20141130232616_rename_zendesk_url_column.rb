class RenameZendeskUrlColumn < ActiveRecord::Migration
  def up
    remove_column :tickets, :zendesk_ticket_url 
    add_column :tickets, :zendesk_ticket_id, :integer
  end

  def down
  end
end
