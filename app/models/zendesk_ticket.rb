require 'zendesk_api'

class ZendeskTicket

	attr_accessor :subject, :description, :priority, :requester_name, :requester_email

	# This corresponds to the Groups in Zendesk, and are [name, group_id] key/value pairs
	# Group IDs can be found by going to https://yourcompany.zendesk.com/agent/admin/people
	# Click Groups and hover over each group to see the link and group ID at the bottom
	GROUPS = { application_support: 21157393, mobile_apps: 21966106 }

	def initialize(platform)
		# Set up ZenDesk API
		@client = ZendeskAPI::Client.new do |config|
			config.url = "https://yourcompany.zendesk.com/api/v2"
			config.username = 'username@email.com/token'
			config.token = "<insert_zendesk_token_here>"
		end
		@subject = ""
		@description = ""
		@priority = ""
		@requester_name = ""
		@requester_email = ""
		@platform = platform
	end

	# Build the Zendesk ticket from the Ticket object
	# base_url is the base URL of this application
	def build(ticket, base_url)
		@subject = ticket.subject
		@requester_name = ticket.from_name
		@requester_email = ticket.from_email
		@priority = ticket.priority
		@description = "Platform: #{ticket.platform} \r\n"
		@description += "Application: #{ticket.application} \r\n"
		@description += "User info: #{base_url}/tickets/#{ticket.id} \r\n"
		@description += "Error message: #{ticket.error_message} \r\n" 
		@description += "URL: #{ticket.problem_url} \r\n"
		@description += "Web browser: #{ticket.web_browser} \r\n"
		@description += "Screen shot: #{base_url}/tickets/#{ticket.id} \r\n" unless ticket.image_url.blank?
		@description += "Description: \r\n"
		@description += ticket.description
	end


	# Create the ticket and submit to Zendesk through API
	def create
		if (@platform == "Web")
			group = GROUPS[:application_support]
		else
			group = GROUPS[:mobile_apps]
		end
			
		ticket = @client.tickets.create(subject: @subject, comment: {value: @description}, 
			requester: {name: @requester_name, email: @requester_email}, priority: @priority,
			group_id: group)
	end
end
