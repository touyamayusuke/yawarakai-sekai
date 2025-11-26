require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board = boards(:one)
    @post = posts(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should create post" do
    assert_difference("Post.count") do
      post board_posts_url(@board), params: { post: { body: "Test post" } }
    end
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete board_post_url(@board, @post)
    end
  end
end
