class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not a valid email")
    end
  end
end


class User < ActiveRecord::Base
  attr_accessible :email, :name

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true

  has_many :tickets

  def self.authenticate(email)
  	user = User.find_by_email(email)
  end

end
