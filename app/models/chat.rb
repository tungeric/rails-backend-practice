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
  def self.get_unexpired(username)
    now = DateTime.now
    chats = from('chats').where("lower(username) @@ :username", username: username.downcase)
    chats.select{ |chat| chat.expiration_date > now }
  end

  def expiration_date
    expired_time = self.created_at.to_i + self.timeout
    local_expired_time = DateTime.strptime(expired_time.to_s,'%s').in_time_zone(Time.current.zone)
    display_time = local_expired_time.strftime("%Y-%m-%d %H:%M:%S")
  end
end
