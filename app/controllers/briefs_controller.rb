class BriefsController < ApplicationController
  before_action :set_brief, only: %i[show edit update destroy]

  def index
    @status = params[:status]
    @briefs = Brief.with_status(@status).newest_first
    @brief = Brief.new
  end

  def show
    if turbo_frame_request?
      render partial: "briefs/brief", locals: { brief: @brief }
    else
      redirect_to briefs_path
    end
  end

  def new
    @brief = Brief.new
  end

  def create
    @brief = Brief.new(brief_params)

    if @brief.save
      @briefs = Brief.newest_first
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to briefs_path, notice: "Brief added." }
      end
    else
      @status = nil
      @briefs = Brief.newest_first
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @brief.update(brief_params)
      respond_to do |format|
        format.turbo_stream
        format.html { render :edit }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @brief.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to briefs_path, notice: "Brief removed." }
    end
  end

  private

  def set_brief
    @brief = Brief.find(params[:id])
  end

  def brief_params
    params.expect(brief: [ :title, :status, :body, :requester ])
  end
end
