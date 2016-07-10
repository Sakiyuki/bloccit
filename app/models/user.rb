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
#  role            :integer
#

class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # def posts
    # Post.find(user: self.id)
  before_create :generate_auth_token
  # #2
  before_save { self.email = email.downcase if email.present? }
  before_save { self.role ||= :member }
  # before_save { self.role ||= :moderator }


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

  enum role: [:member, :admin]

  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def generate_auth_token
    loop do
      self.auth_token = SecureRandom.base64(64)
      break unless User.find_by(auth_token: auth_token)
    end
  end
end
