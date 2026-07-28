class BriefRowComponent < ViewComponent::Base
  def initialize(brief:)
    @brief = brief
  end

  attr_reader :brief
end
