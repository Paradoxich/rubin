require "test_helper"

class BriefsControllerTest < ActionDispatch::IntegrationTest
  include ActionView::RecordIdentifier

  # What Turbo sends when submitting a form: streams preferred, HTML fallback.
  TURBO_ACCEPT = { "Accept" => "text/vnd.turbo-stream.html, text/html" }.freeze

  setup do
    @brief = briefs(:one)
  end

  test "index lists briefs and keeps the empty state on standby" do
    get briefs_url

    assert_response :success
    assert_select ".brief-row__title", text: @brief.title
    assert_select ".brief-list .empty", count: 1
  end

  test "index filters by status" do
    get briefs_url(status: "inbox")

    assert_response :success
    assert_select ".brief-row__title", text: briefs(:two).title
    assert_select ".brief-row__title", text: @brief.title, count: 0
  end

  test "index ignores unknown status filters" do
    get briefs_url(status: "nope")

    assert_select ".brief-row", count: Brief.count
  end

  test "create rerenders the list and closes the form via turbo stream" do
    assert_difference("Brief.count") do
      post briefs_url,
        params: { brief: { title: "Docs sweep", requester: "Sam Reyes" } },
        headers: TURBO_ACCEPT
    end

    assert_turbo_stream action: :update, target: "briefs" do
      assert_select ".brief-row__title", text: "Docs sweep"
    end
    assert_turbo_stream action: :update, target: "new_brief"
    assert_turbo_stream action: :update, target: "flash" do
      assert_select ".flash__message", text: "Brief added."
    end
  end

  test "create keeps the active status filter" do
    post briefs_url,
      params: { status: "approved", brief: { title: "Docs sweep", requester: "Sam Reyes", status: "inbox" } },
      headers: TURBO_ACCEPT

    assert_turbo_stream action: :update, target: "briefs" do
      assert_select ".brief-row", count: 0
      assert_select ".empty", count: 1
    end
  end

  test "create without turbo redirects back to the filtered lane" do
    post briefs_url, params: { status: "inbox", brief: { title: "Docs sweep", requester: "Sam Reyes" } }

    assert_redirected_to briefs_path(status: "inbox")
  end

  test "create with invalid params rerenders the form" do
    assert_no_difference("Brief.count") do
      post briefs_url, params: { brief: { title: "", requester: "" } }, headers: TURBO_ACCEPT
    end

    assert_response :unprocessable_entity
    assert_select ".form-errors"
  end

  test "update replaces the row via turbo stream" do
    patch brief_url(@brief), params: { brief: { status: "approved" } }, headers: TURBO_ACCEPT

    assert_turbo_stream action: :replace, target: dom_id(@brief)
    assert_equal "approved", @brief.reload.status
  end

  test "update removes the row when it leaves the filtered lane" do
    patch brief_url(@brief),
      params: { status: "in_review", brief: { status: "approved" } },
      headers: TURBO_ACCEPT

    assert_turbo_stream action: :remove, target: dom_id(@brief)
    assert_equal "approved", @brief.reload.status
  end

  test "update without turbo redirects to the index" do
    patch brief_url(@brief), params: { brief: { title: "Renamed" } }

    assert_redirected_to briefs_path
  end

  test "update with invalid params rerenders the editor" do
    patch brief_url(@brief), params: { brief: { title: "" } }, headers: TURBO_ACCEPT

    assert_response :unprocessable_entity
    assert_select ".form-errors"
    assert_equal "Homepage hero pass", @brief.reload.title
  end

  test "destroy removes the row via turbo stream" do
    assert_difference("Brief.count", -1) do
      delete brief_url(@brief), headers: TURBO_ACCEPT
    end

    assert_turbo_stream action: :remove, target: dom_id(@brief)
  end

  test "show renders just the row for turbo frame requests" do
    get brief_url(@brief), headers: { "Turbo-Frame" => dom_id(@brief) }

    assert_response :success
    assert_select ".brief-row__title", text: @brief.title
  end

  test "show redirects to the index outside a frame" do
    get brief_url(@brief)

    assert_redirected_to briefs_path
  end
end
