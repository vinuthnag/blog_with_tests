class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit,:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = @current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to @post, notice: @comment.errors.full_messages}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:description, :post_id, :user_id)
    end
end
