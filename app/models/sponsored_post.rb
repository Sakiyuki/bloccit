# == Schema Information
#
# Table name: sponsored_posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  price      :integer
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SponsoredPost < ActiveRecord::Base
  belongs_to :topic
end
