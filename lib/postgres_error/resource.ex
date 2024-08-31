defmodule PostgresError.Resource do
  use Ash.Domain

  resources do
    resource PostgresError.Resource.MapError
  end
end
