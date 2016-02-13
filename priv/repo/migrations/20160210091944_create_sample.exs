defmodule PhoenixSample.Repo.Migrations.CreateSample do
  use Ecto.Migration

  def change do
    create table(:hoges) do
      add :one, :integer
      add :two, :float
      add :three, :boolean
      add :four, :string
      add :five, :map
      add :six, :binary
      add :seven, :decimal
      add :eight, :datetime
      add :nine, :date
      add :ten, :time

    end
  
  end
end
