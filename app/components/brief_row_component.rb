class BriefRowComponent < ViewComponent::Base
  def initialize(brief:, filter_status: nil)
    @brief = brief
    @filter_status = filter_status
  end

  attr_reader :brief, :filter_status
end
