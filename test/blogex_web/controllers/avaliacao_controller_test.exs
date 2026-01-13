defmodule BlogexWeb.AvaliacaoControllerTest do
  use BlogexWeb.ConnCase

  import Blogex.AvaliacoesFixtures
  alias Blogex.Avaliacoes.Avaliacao

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup :register_and_log_in_user

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all disciplinas", %{conn: conn} do
      conn = get(conn, ~p"/api/disciplinas")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create avaliacao" do
    test "renders avaliacao when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/disciplinas", avaliacao: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/disciplinas/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/disciplinas", avaliacao: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update avaliacao" do
    setup [:create_avaliacao]

    test "renders avaliacao when data is valid", %{conn: conn, avaliacao: %Avaliacao{id: id} = avaliacao} do
      conn = put(conn, ~p"/api/disciplinas/#{avaliacao}", avaliacao: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/disciplinas/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, avaliacao: avaliacao} do
      conn = put(conn, ~p"/api/disciplinas/#{avaliacao}", avaliacao: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete avaliacao" do
    setup [:create_avaliacao]

    test "deletes chosen avaliacao", %{conn: conn, avaliacao: avaliacao} do
      conn = delete(conn, ~p"/api/disciplinas/#{avaliacao}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/disciplinas/#{avaliacao}")
      end
    end
  end

  defp create_avaliacao(%{scope: scope}) do
    avaliacao = avaliacao_fixture(scope)

    %{avaliacao: avaliacao}
  end
end
