defmodule MyAppWeb.SessionControllerTest do
  use MyAppWeb.ConnCase

  alias MyApp.Auth
  alias Plug.Test

  @create_attrs %{
    email: "some email",
    is_active: true,
    password: "some password"
  }

  @current_user_attrs %{
    email: "some current user email",
    is_active: true,
    password: "some current user password"
  }

  @inactive_user_attrs %{
    email: "inactive user email",
    is_active: false,
    password: "some current user password"
  }

  def fixture(:user) do
    {:ok, user} = Auth.create_user(@create_attrs)
    user
  end

  def fixture(:current_user) do
    {:ok, current_user} = Auth.create_user(@current_user_attrs)
    current_user
  end

  def fixture(:inactive_user) do
    {:ok, inactive_user} = Auth.create_user(@inactive_user_attrs)
    inactive_user
  end

  setup %{conn: conn} do
    {:ok, conn: conn, current_user: current_user} = setup_current_user(conn)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), current_user: current_user}
  end


  describe "sign_in user" do
    test "renders user when user credentials are good", %{conn: conn, current_user: current_user} do
      conn =
        post(
          conn,
          Routes.session_path(conn, :create, %{
            email: current_user.email,
            password: @current_user_attrs.password
          })
        )

      assert json_response(conn, 200)["data"] == %{
               "user" => %{"id" => current_user.id, "email" => current_user.email}
             }
    end

    test "renders error when user is not active", %{conn: conn} do
      inactive_user = fixture(:inactive_user)
      conn =
        post(
          conn,
          Routes.session_path(conn, :create, %{
            email: inactive_user.email,
            password: @inactive_user_attrs.password
          })
        )

      assert json_response(conn, 401)["errors"] == %{"detail" => "Wrong email or password"}

    end

    test "renders error when user credentials are bad", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.session_path(conn, :create, %{
            email: "asdflkjdflkj",
            password: ""
          })
        )

      assert json_response(conn, 401)["errors"] == %{"detail" => "Wrong email or password"}
    end
  end

  defp setup_current_user(conn) do
    current_user = fixture(:current_user)

    {:ok,
     conn: Test.init_test_session(conn, current_user_id: current_user.id),
     current_user: current_user}
  end

end
