defmodule Blogex.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:title, :content]
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "posts" do
    field :title, :string
    field :content, :string
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
