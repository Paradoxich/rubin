class BriefsController < ApplicationController
  DEFAULT_LIMIT = 5

  before_action :set_brief, only: %i[show edit update destroy]

  def index
    @status = params[:status]
    briefs = Brief.with_status(@status).newest_first
    @total = briefs.count
    @briefs = params[:all].present? ? briefs : briefs.limit(DEFAULT_LIMIT)
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
    @status = filter_status

    if @brief.save
      briefs = Brief.with_status(@status).newest_first
      @total = briefs.count
      @briefs = briefs.limit(DEFAULT_LIMIT)
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
    @status = filter_status

    if @brief.update(brief_params)
      notice = "Brief updated."
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = notice }
        format.html { redirect_to briefs_path(status: @status), notice: notice }
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

  # The active list filter, carried by forms as a top-level status param.
  def filter_status
    status = params[:status].presence
    status if Brief::STATUSES.include?(status)
  end
end
