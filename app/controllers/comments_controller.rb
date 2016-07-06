class CommentsController < ApplicationController
  # #10
  before_action :require_sign_in
# #15
  before_action :authorize_user, only: [:destroy]

  def destroy
     @post = Post.find(params[:post_id])
     @comment = @post.comments.find(params[:id])

     if @comment.destroy
       flash[:notice] = "Comment was deleted successfully."
     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
     end

     respond_to do |format|
       format.html
       format.js
     end
   end

  def create
# #11
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @new_comment = Comment.new

    if @comment.save
      flash[:notice] = "Comment saved successfully."
# #12
    else
      flash[:alert] = "Comment failed to save."
# #13
    end

    respond_to do |format|
      format.html
      format.js
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
