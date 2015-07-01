class CommentsController < ApplicationController
  before_action :load_commentable
  respond_to :html, :json

  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
    respond_with(@comment)
  end

  def show
    respond_with(@comment)
  end

  # rubocop:disable all
  def create
    @comment = @commentable.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment }
        format.json { render json: @comment }
      else
        format.html { render action: new }
        format.json { render json: @comment.errors,
                             status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable all

  # rubocop:disable all
  def destroy
    if @commentable.comments.find(params[:id]).destroy
      render json: { success: true }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(
      :content,
      comments_attributes: [
        :id,
        :content,
        :_destroy
      ],
      attachments_attributes: [
        :id,
        :file,
        :_destroy
      ]
    )
  end
  # rubocop:enable all

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
