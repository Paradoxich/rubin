class StatusBadgeComponent < ViewComponent::Base
  def initialize(status:)
    @status = status
  end

  def call
    helpers.tag.span(label, class: helpers.class_names("badge", "type-body-sm", "badge--#{@status}"))
  end

  private

  def label
    Brief.status_label(@status)
  end
end
