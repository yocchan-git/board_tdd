require "test_helper"

class PostsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user1 = users(:michael)
    @user2 = users(:inactive)

    @post1 = posts(:post_one)
    @post2 = posts(:post_two)
  end

  test "投稿のタイトルが詳細ページへのリンクになっているかチェックする" do
    log_in_as(@user1)
    get posts_path
    assert_select "a[href=?]", post_path(@post1)
    assert_select "a[href=?]", post_path(@post2)
  end

  test "投稿した人の名前が表示されているかチェックする" do
    log_in_as(@user1)
    get posts_path
    assert_select "p", @user1.name
    assert_select "p", @user2.name
  end
end
