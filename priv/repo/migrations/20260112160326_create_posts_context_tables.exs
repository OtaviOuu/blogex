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

    create table(:likes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :post_id, references(:posts, type: :binary_id), null: false
      add :user_id, references(:users, type: :integer), null: false

      timestamps()
    end

    create unique_index(:likes, [:user_id, :post_id], name: :likes_user_id_post_id_index)
  end
end
