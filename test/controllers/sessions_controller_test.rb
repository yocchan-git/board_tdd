require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:michael)
    end
end

# ログイン関連のコントローラテスト
class LoginTest < SessionsControllerTest

  test "ログイン画面にアクセスする" do
    get "/login"
    assert_response :success
  end

  test "正しい認証情報でログインする" do
    post "/login", params:{email: @user.email, password: 'password'}
    assert_not flash.empty?
    assert_redirected_to posts_path
    assert_equal session[:user_id], @user.id
  end
end

# ログアウト関連のコントローラテスト
class LogoutTest < SessionsControllerTest
  test "logoutに通信できるかどうか？" do
    delete "/logout"
    assert_response :success
  end

  # ERROR:log_in_asメソッドでエラーが発生する
  test "logoutの処理が正しく行われているのか？" do
    # post "/login", params:{email: @user.email, password: 'password'}
    log_in_as(@user)
    delete "/logout"
    # TODO:　ログアウトの処理
    assert session[:user_id].nil?
    assert_not flash.empty?
    assert_redirected_to login_path
    assert_nil @current_user
  end
end
