defmodule PostgresError.Resource.MapError do
  use Ash.Resource,
    otp_app: :postgres_error,
    domain: PostgresError.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "map_errors"
    repo PostgresError.Repo
  end

  code_interface do
    define :create, action: :create
    define :update, action: :update
    define :bug_here, action: :bug_here
  end

  actions do
    defaults [:destroy, :read, update: :*, create: :*]

    update :bug_here do
      accept [:*]
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :nested_map, :map, public?: true
  end
end
