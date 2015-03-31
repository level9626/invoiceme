class IvTemplatesController < ApplicationController
  before_action :set_iv_template, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @iv_templates = IvTemplate.all
    respond_with(@iv_templates)
  end

  def show
    respond_with(@iv_template)
  end

  def new
    @iv_template = IvTemplate.new
    respond_with(@iv_template)
  end

  def edit
  end

  def create
    @iv_template = IvTemplate.new(iv_template_params)
    @iv_template.save
    respond_with(@iv_template)
  end

  def update
    @iv_template.update(iv_template_params)
    respond_with(@iv_template)
  end

  def destroy
    @iv_template.destroy
    respond_with(@iv_template)
  end

  private
    def set_iv_template
      @iv_template = IvTemplate.find(params[:id])
    end

    def iv_template_params
      params.require(:iv_template).permit(:name)
    end
end
