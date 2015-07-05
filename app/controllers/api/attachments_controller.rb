module Api
  class AttachmentsController < ApplicationController
    before_action :load_attachable
    respond_to :html, :json

    def index
      @attachments = @attachable.attachments
    end

    def new
      @attachment = @attachable.attachments.new
      respond_with(@attachment)
    end

    def show
      respond_with(@attachment)
    end

    # rubocop:disable all
    def create
      @attachment = @attachable.attachments.new(comment_params)
      if @attachment.save
        respond_to do |format|
          format.html { redirect_to @attachable }
          format.js
        end
      end
    end
    # rubocop:enable all

    def destroy
    end

    private

    def comment_params
      params.require(:attachment).permit(:file)
    end

    def load_attachable
      resource, id = request.path.split('/')[1, 2]
      @attachable = resource.singularize.classify.constantize.find(id)
    end
  end
end
