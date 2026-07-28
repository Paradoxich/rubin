class BriefsController < ApplicationController
  before_action :set_brief, only: %i[show edit update destroy]

  def index
    @status = params[:status]
    @briefs = Brief.with_status(@status).newest_first
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
    @status = params[:status].presence

    if @brief.save
      @briefs = Brief.with_status(@status).newest_first
      notice = "Brief added."
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = notice }
        format.html { redirect_to briefs_path(status: @status), notice: notice }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @brief.update(brief_params)
      notice = "Brief updated."
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = notice }
        format.html { redirect_to briefs_path, notice: notice }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @brief.destroy!

    notice = "Brief removed."
    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = notice }
      format.html { redirect_to briefs_path, notice: notice }
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
