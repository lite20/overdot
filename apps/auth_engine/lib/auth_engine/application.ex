defmodule AuthEngine.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # initiate dbs
    db_props = %{
      protocol: "http",
      hostname: "localhost",
      database: "psq_user",
      port: 5984
    }

    lookup_db_props = %{
      protocol: "http",
      hostname: "localhost",
      database: "psq_lookup",
      port: 5984
    }

    # set up connectors
    Couchdb.Connector.Storage.storage_up(db_props)
    Couchdb.Connector.Storage.storage_up(lookup_db_props)

    children = [
      worker(AuthEngine, [
        %{
          db: db_props,
          user_lookup: lookup_db_props
        }
      ])
    ]

    opts = [strategy: :one_for_one, name: AuthEngine.Supervisor]
    Supervisor.start_link(children, opts)
  end
end