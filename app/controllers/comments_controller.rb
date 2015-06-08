class CommentsController < ApplicationController
  before_action :load_commentable
  respond_to :html, :json

  def index
    @comments = @commentable.comments
  end
``
  def new
    @comment = @commentable.comments.new
    respond_with(@comment)
  end

  def show
    respond_with(@comment)
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.save
    render json: @comment
  end

  def destroy
    if @commentable.comments.find(params[:id]).destroy
      render json: { success: true }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
