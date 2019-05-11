class CommentsController < ApplicationController
  before_action :authenticate_brand!
  
  def create
    @comment = Comment.new(comment_params)
    @comment.brand = current_brand
    @promoter = User.find_by(username: params[:comment][:username])
    @comment.promoter_id = @promoter.id
    
    respond_to do |format|
      if @comment.save
        @comments = Comment.where(promoter_id: @promoter.id).order("created_at DESC")
        format.js { render :layout => false }
      end
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end
