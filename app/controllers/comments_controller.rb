class CommentsController < ApplicationController
  # #10
  before_action :require_sign_in
# #15
  before_action :authorize_user, only: [:destroy]

  def destroy
    # dealing with topic comments

    @commentable = Post.find(params[:post_id]) if params[:post_id]
    @commentable = Topic.find(params[:topic_id]) if params[:topic_id]
    comment = @commentable.comments.find(params[:id])

    # if params[:topic_id]
    #   @topic = Topic.find(params[:topic_id])
    #   comment = @topic.comments.find(params[:id])
    # end
    #
    # # dealing with post comments
    # if params[:post_id]
    #   @post = Post.find(params[:post_id])
    #   comment = @post.comments.find(params[:id])
    # end

     if comment.destroy
       flash[:notice] = "Comment was deleted successfully."

       redirect_to [@commentable.topic, @commentable] if @commentable.class == Post
       redirect_to [@commentable] if @commentable.class == Topic
     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
       
       redirect_to [@commentable.topic, @commentable] if @commentable.class == Post
       redirect_to [@commentable] if @commentable.class == Topic
     end
   end


  def create
# #11
    @commentable = Post.find(params[:post_id]) if params[:post_id]
    @commentable = Topic.find(params[:topic_id]) if params[:topic_id]
    comment = @commentable.comments.new(comment_params)
    comment.user = current_user

    if comment.save
       flash[:notice] = "Comment saved successfully."
# #12
       redirect_to [@commentable.topic, @commentable] if @commentable.class == Post
       redirect_to [@commentable] if @commentable.class == Topic

     else
       flash[:alert] = "Comment failed to save."
# #13
       redirect_to [@commentable.topic, @commentable] if @commentable.class == Post
       redirect_to [@commentable] if @commentable.class == Topic
     end
    end

    private
# #14
    def comment_params
     params.require(:comment).permit(:body)
    end

# #16
    def authorize_user
      comment = Comment.find(params[:id])
      unless current_user == comment.user || current_user.admin?
        flash[:alert] = "You do not have permission to delete a comment."
        redirect_to [comment.post.topic, comment.post]
     end
    end
 end
