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

require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph}
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:price) { rand(0..1000) }

  let(:topic) { Topic.create!(name: name, description: description) }
  let(:sponsored_post) {topic.sponsored_posts.create!( title: title, body: body, price: price) }

  it { is_expected.to belong_to(:topic)}

  describe "attributes" do
    it "has title body and price attributes" do
      expect(sponsored_post).to have_attributes(title: title, body: body, price: price)
    end
  end
end
