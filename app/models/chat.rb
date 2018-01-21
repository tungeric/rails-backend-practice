# == Schema Information
#
# Table name: chats
#
#  id         :integer          not null, primary key
#  username   :string           not null
#  text       :string           not null
#  timeout    :integer          default(60)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Chat < ApplicationRecord
  validates :username, :text, :timeout, presence: true

  def self.get_unexpired(username)
    now = Time.now
    chats = from('chats').where("lower(username) @@ :username", username: username.downcase)
    chats.select{ |chat| chat.expiration_date > now }
  end

  def expiration_date
    expired_time = Time.at(self.created_at.to_i + self.timeout)
  end

  def display_expiration_date
    self.expiration_date.strftime("%Y-%m-%d %H:%M:%S")
  end
end
