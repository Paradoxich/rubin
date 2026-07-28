require "test_helper"

class BriefTest < ActiveSupport::TestCase
  test "requires title, requester, and a known status" do
    brief = Brief.new(body: "Notes only")

    assert_not brief.valid?
    assert_includes brief.errors[:title], "can't be blank"
    assert_includes brief.errors[:requester], "can't be blank"
  end

  test "defaults status to inbox on create" do
    brief = Brief.create!(title: "New lane", requester: "Alex")

    assert_equal "inbox", brief.status
  end

  test "with_status filters known lanes and ignores unknown ones" do
    assert_equal 1, Brief.with_status("inbox").count
    assert_equal Brief.count, Brief.with_status("nope").count
  end
end
