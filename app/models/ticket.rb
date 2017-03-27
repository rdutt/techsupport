

class Ticket < ActiveRecord::Base
  attr_accessible :application, :description, :error_message, :from_email, :member1, :member2, 
    :platform, :priority, :subject, :zendesk_ticket_id, :from_name, :user_id, :problem_url,
    :web_browser, :consultation_id, :image

  validates :platform, presence: true
  validates :application, presence: true
  validates :subject, presence: true
  validates :description, presence: true
  validates :from_name, presence: true
  validates :from_email, presence: true
  validates :web_browser, presence: true
  validates :error_message, presence: true

  belongs_to :user
  mount_uploader :image, ImageUploader

  PLATFORMS = ["Web",  "Mobile"]

  # List your apps here
  APPS = ["App1", "App2", "App3"]

  PRIORITIES = ["Normal", "High", "Critical"]

  WEB_BROWSERS = ["Unknown", "Chrome", "Firefox", "IE 9 or above", "IE 8", "Safari", "MS Edge"]
  	
end
