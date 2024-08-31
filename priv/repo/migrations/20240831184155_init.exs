defmodule PostgresError.Repo.Migrations.Init do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:map_errors, primary_key: false) do
      add :id, :uuid, null: false, default: fragment("gen_random_uuid()"), primary_key: true
      add :nested_map, :map
    end
  end

  def down do
    drop table(:map_errors)
  end
end
