defmodule Blogex.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blogex.Accounts.User

  @fields [:title, :content]
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "posts" do
    field :title, :string
    field :content, :string

    belongs_to :author, User, type: :integer, foreign_key: :author_id

    timestamps()
  end

  def changeset(attrs, %{user: %User{} = user}) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> put_assoc(:author, user)
  end
end
