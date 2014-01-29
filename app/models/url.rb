# require 'uri'
class Url < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  validates_format_of :original_url, :with => URI::regexp(%w(http https)) #, :message => 'The URL you entered is not valid. No HTTP:// or HTTPS://')
end
