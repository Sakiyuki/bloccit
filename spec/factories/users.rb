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

FactoryGirl.define do
  pw = RandomData.random_sentence
  # #3
  factory :user do
    name RandomData.random_name
    # #4
    sequence(:email){|n| "user#{n}@factory.com"}
    password pw
    password_confirmation pw
    role :member
  end

  trait :user_with_posts do
    after(:create) do |user_with_posts|
      3.times do
        user_with_posts.posts << FactoryGirl.create(:post)
        # user_with_posts.favorites.posts << FactoryGirl.create(:post)
      end
    end
  end
end
