defmodule MyApp.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :email, :string, null: false
      add :user_id, :integer, null: false

      timestamps()
    end

  end
end
