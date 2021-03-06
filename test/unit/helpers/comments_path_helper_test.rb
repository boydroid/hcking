require 'test_helper'

class CommentsPathHelperTest < ActionView::TestCase
  include CommentsPathHelper

  test "get edit comment path" do
    assert_equal "/events/1/single_events/1/comments/1/edit", edit_comment_path(Factory(:single_event).comments.create)
    assert_equal "/events/2/comments/2/edit", edit_comment_path(Factory(:simple).comments.create)
  end

  test "comment path" do
    assert_equal "/events/1/single_events/1/comments/1", comment_path(Factory(:single_event).comments.create)
    assert_equal "/events/2/comments/2", comment_path(Factory(:simple).comments.create)
  end

  test "comments path" do
    assert_equal "/events/1/single_events/1/comments", comments_path(Factory(:single_event).comments.create)
    assert_equal "/events/2/comments", comments_path(Factory(:simple).comments.create)
  end

  test "commentable path" do
    assert_equal "/events/1/single_events/1", commentable_path(Factory(:single_event).comments.create)
    assert_equal "/events/2", commentable_path(Factory(:simple).comments.create)
  end

end
