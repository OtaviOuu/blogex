defmodule Blogex.Posts.PostTag do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blogex.Posts.{Tag, Post}

  @fields [:post_id, :tag_id]
  @primary_key false
  schema "post_tags" do
    belongs_to :post, Post
    belongs_to :tag, Tag

    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
