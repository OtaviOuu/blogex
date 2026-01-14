defmodule Blogex.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Blogex.Accounts.User
  alias Blogex.Posts.Post

  @fields [:title, :content]
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "posts" do
    field :title, :string
    field :content, :string

    field :likes_count, :integer, virtual: true, default: 0

    belongs_to :author, User, type: :integer, foreign_key: :author_id
    has_many :likes, Blogex.Posts.Like, foreign_key: :post_id

    timestamps()
  end

  def changeset(attrs, %{user: %User{} = user}) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> put_assoc(:author, user)
  end

  def calculate_like_count(query) do
    from p in query,
      left_join: l in assoc(p, :likes),
      group_by: p.id,
      select: p,
      select_merge: %{likes_count: count(l.id)}
  end

  def get_by_id(id) do
    from p in Post,
      where: p.id == ^id
  end
end
