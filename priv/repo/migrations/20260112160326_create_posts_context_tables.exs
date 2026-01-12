defmodule Blogex.Repo.Migrations.CreatePostsContextTables do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :content, :text, null: false
      add :author_id, references(:users), null: false

      timestamps()
    end

    create table(:tags) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:tags, [:name])

    create table(:post_tags, primary_key: false) do
      add :post_id, references(:posts, type: :binary_id), null: false
      add :tag_id, references(:tags), null: false

      timestamps()
    end

    create unique_index(:post_tags, [:post_id, :tag_id])
  end
end
