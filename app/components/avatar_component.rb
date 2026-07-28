class AvatarComponent < ViewComponent::Base
  def initialize(name:)
    @name = name.to_s.strip
  end

  def call
    helpers.tag.span(
      initials,
      class: "avatar",
      title: @name.presence,
      aria: { label: @name.presence }
    )
  end

  private

  def initials
    parts = @name.split(/\s+/).reject(&:blank?)
    return "?" if parts.empty?
    return parts.first.first(2).upcase if parts.one?

    "#{parts.first[0]}#{parts.last[0]}".upcase
  end
end
