defmodule Blogex.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blogex.Accounts.User

  @fields [:title, :content, :author_id]
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "posts" do
    field :title, :string
    field :content, :string

    belongs_to :author, User

    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
