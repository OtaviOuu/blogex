defmodule Blogex.Posts.Like do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:post_id]
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "likes" do
    belongs_to :post, Blogex.Posts.Post, type: :binary_id, foreign_key: :post_id
    belongs_to :user, Blogex.Accounts.User, type: :integer, foreign_key: :user_id

    timestamps()
  end

  def changeset(attrs, scope) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> put_assoc(:user, scope.user)
    |> unique_constraint(:user_post_unique, name: :likes_user_id_post_id_index)
  end
end
