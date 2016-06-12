# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_many :posts

  # def posts
    # Post.find(user: self.id)
  # end

  # #2
  before_save { self.email = email.downcase if email.present? }

  # #3
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  # #4
  validates :password, presence: true, length: { minimum: 6}, unless: :password_digest
  validates :password, length: { minimum: 6 }, allow_blank: true

  # #5
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  has_secure_password
end
