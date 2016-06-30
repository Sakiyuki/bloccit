class FavoriteMailer < ApplicationMailer
  default from: "youremail@email.com"

  def new_comment(user, post, comment)

# #18
    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
    headers["References"] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    @comment = comment

# #19
    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(post, user)
     headers["Message-ID"] = "<post/#{post.id}@your-app-name.example>"
     headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
     headers["References"] = "<post/#{post.id}@your-app-name.example>"

     @post = post
     @user = user


     mail(to: user.email, subject: "New Post on, #{post.title}")
  end
end
