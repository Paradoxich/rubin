class Brief < ApplicationRecord
  STATUSES = %w[inbox in_review approved].freeze

  validates :title, presence: true, length: { maximum: 120 }
  validates :requester, presence: true, length: { maximum: 80 }
  validates :status, inclusion: { in: STATUSES }
  validates :body, length: { maximum: 2000 }, allow_blank: true

  before_validation :assign_default_status, on: :create

  scope :newest_first, -> { order(updated_at: :desc) }
  scope :with_status, ->(status) {
    status.present? && STATUSES.include?(status) ? where(status: status) : all
  }

  def self.status_label(status)
    status.to_s.tr("_", " ").titleize
  end

  def status_label
    self.class.status_label(status)
  end

  private

  def assign_default_status
    self.status = "inbox" if status.blank?
  end
end
