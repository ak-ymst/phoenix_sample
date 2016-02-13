defmodule PhoenixSample.Repo.Migrations.ModifyContentsToPost do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      modify :content, :text

    end
      
  end
end
