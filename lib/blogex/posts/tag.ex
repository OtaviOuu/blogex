defmodule Blogex.Posts.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:name]
  schema "tags" do
    field :name, :string

    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:name)
  end
end
