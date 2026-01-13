defmodule Blogex.AvaliacoesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blogex.Avaliacoes` context.
  """

  @doc """
  Generate a avaliacao.
  """
  def avaliacao_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        name: "some name"
      })

    {:ok, avaliacao} = Blogex.Avaliacoes.create_avaliacao(scope, attrs)
    avaliacao
  end
end
