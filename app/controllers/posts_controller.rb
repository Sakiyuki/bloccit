class PostsController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]

  before_action :authorize_moderator, only: [:edit, :update]
  before_action :authorize_admin, only: [:destroy]

  def show
    @post = Post.find(params[:id])
  end

  def new
    # #7
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end


  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    # #14
    @post.user = current_user
    # #10
    if @post.save
    # #11
      flash[:notice] = "Post was saved successfully."
      redirect_to [@topic, @post]
    else
  # #12
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated successfully."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "Ther was an error saving the post. Pleas try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

# #8
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

# remember to add private methods to the bottom of the file.  Any method defined below private, will be private.
  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  # admin              - new, create, edit, update, delete
  # user w/ own post   - new, create, edit, update, delete
  # mod not own post   - new, create, edit, update
  # member             - new, create
  # member not own post- nothing

  def authorize_moderator
    post = Post.find(params[:id])

    unless current_user.moderator? || current_user.admin? || current_user == post.user
      flash[:alert] = "You must be an admin or the owner to do that."
      redirect_to [post.topic, post]
    end
  end

  def authorize_admin
    post = Post.find(params[:id])

    unless current_user.admin? || current_user == post.user
      flash[:alert] = "You must be admin or the owner to do that."
      redirect_to [post.topic, post]
    end
  end

end
