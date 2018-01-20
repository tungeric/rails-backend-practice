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

require 'test_helper'

class ChatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
