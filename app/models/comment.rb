# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string
#

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
end
