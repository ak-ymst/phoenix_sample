defmodule PhoenixSample.Repo.Migrations.AddSmallintToHoge do
  use Ecto.Migration

  def change do
    alter table(:hoges) do
      add :eleven, :smallint

    end
  end
end
