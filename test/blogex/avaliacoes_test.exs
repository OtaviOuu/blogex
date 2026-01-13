defmodule Blogex.AvaliacoesTest do
  use Blogex.DataCase

  alias Blogex.Avaliacoes

  describe "disciplinas" do
    alias Blogex.Avaliacoes.Avaliacao

    import Blogex.AccountsFixtures, only: [user_scope_fixture: 0]
    import Blogex.AvaliacoesFixtures

    @invalid_attrs %{name: nil}

    test "list_disciplinas/1 returns all scoped disciplinas" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      avaliacao = avaliacao_fixture(scope)
      other_avaliacao = avaliacao_fixture(other_scope)
      assert Avaliacoes.list_disciplinas(scope) == [avaliacao]
      assert Avaliacoes.list_disciplinas(other_scope) == [other_avaliacao]
    end

    test "get_avaliacao!/2 returns the avaliacao with given id" do
      scope = user_scope_fixture()
      avaliacao = avaliacao_fixture(scope)
      other_scope = user_scope_fixture()
      assert Avaliacoes.get_avaliacao!(scope, avaliacao.id) == avaliacao
      assert_raise Ecto.NoResultsError, fn -> Avaliacoes.get_avaliacao!(other_scope, avaliacao.id) end
    end

    test "create_avaliacao/2 with valid data creates a avaliacao" do
      valid_attrs = %{name: "some name"}
      scope = user_scope_fixture()

      assert {:ok, %Avaliacao{} = avaliacao} = Avaliacoes.create_avaliacao(scope, valid_attrs)
      assert avaliacao.name == "some name"
      assert avaliacao.user_id == scope.user.id
    end

    test "create_avaliacao/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Avaliacoes.create_avaliacao(scope, @invalid_attrs)
    end

    test "update_avaliacao/3 with valid data updates the avaliacao" do
      scope = user_scope_fixture()
      avaliacao = avaliacao_fixture(scope)
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Avaliacao{} = avaliacao} = Avaliacoes.update_avaliacao(scope, avaliacao, update_attrs)
      assert avaliacao.name == "some updated name"
    end

    test "update_avaliacao/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      avaliacao = avaliacao_fixture(scope)

      assert_raise MatchError, fn ->
        Avaliacoes.update_avaliacao(other_scope, avaliacao, %{})
      end
    end

    test "update_avaliacao/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      avaliacao = avaliacao_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Avaliacoes.update_avaliacao(scope, avaliacao, @invalid_attrs)
      assert avaliacao == Avaliacoes.get_avaliacao!(scope, avaliacao.id)
    end

    test "delete_avaliacao/2 deletes the avaliacao" do
      scope = user_scope_fixture()
      avaliacao = avaliacao_fixture(scope)
      assert {:ok, %Avaliacao{}} = Avaliacoes.delete_avaliacao(scope, avaliacao)
      assert_raise Ecto.NoResultsError, fn -> Avaliacoes.get_avaliacao!(scope, avaliacao.id) end
    end

    test "delete_avaliacao/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      avaliacao = avaliacao_fixture(scope)
      assert_raise MatchError, fn -> Avaliacoes.delete_avaliacao(other_scope, avaliacao) end
    end

    test "change_avaliacao/2 returns a avaliacao changeset" do
      scope = user_scope_fixture()
      avaliacao = avaliacao_fixture(scope)
      assert %Ecto.Changeset{} = Avaliacoes.change_avaliacao(scope, avaliacao)
    end
  end
end
