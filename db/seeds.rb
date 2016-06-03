require 'random_data'



# Create topics
15.times do
  Topic.create!(
    name:         RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
topics = Topic.all

# Create Posts
50.times do
  # #1
  Post.create!(
  # #2
    topic: topics.sample,
    title: RandomData.random_sentence,
    body:  RandomData.random_paragraph
  )
end
posts = Post.all

#Create Comments
# #3
100.times do
  Comment.create!(
  # #4
      post: posts.sample,
      body: RandomData.random_paragraph
  )
end

# Create SponsoredPosts
20.times do
  SponsoredPost.create!(
    topic:        topics.sample,
    title:        RandomData.random_sentence,
    body:         RandomData.random_paragraph,
    price:        rand(0..1000)
  )
end



puts "Seed finished"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{SponsoredPost.count} sponsored_posts created"
