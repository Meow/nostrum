defmodule Nostrum.Cache.GuildCacheTest do
  use ExUnit.Case

  alias Nostrum.Cache.CacheSupervisor
  alias Nostrum.Cache.Guild.GuildRegister
  alias Nostrum.Cache.GuildCache
  alias Nostrum.Struct.Guild

  setup_all do
    CacheSupervisor.start_link([])
    GuildRegister.create_guild_process(0, %Guild{id: 0})

    :ok
  end

  doctest GuildCache
end
