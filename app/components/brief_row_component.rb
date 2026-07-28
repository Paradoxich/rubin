class BriefRowComponent < ViewComponent::Base
  with_collection_parameter :brief

  def initialize(brief:)
    @brief = brief
  end

  attr_reader :brief
end
