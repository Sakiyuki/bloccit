require 'rails_helper'

RSpec.describe "users/show.html.erb", type: :view do

  before(:each) do
    @user = create :user, :user_with_posts
    Favorite.create!(post: @user.posts.first, user: @user)
  end

  it "renders user favorites" do
    # expect(find('body')).to have_content (@user.favorites.first.post.title)
  end

end
