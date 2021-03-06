defmodule Nostrum.Struct.Guild.AuditLogEntry do
  @moduledoc """
  Represents a single entry in the guild's audit log.
  """

  alias Nostrum.Snowflake
  alias Nostrum.Struct.User
  alias Nostrum.Util

  defstruct [
    :action_type,
    :changes,
    :id,
    :options,
    :reason,
    :target_id,
    :user_id
  ]

  @typedoc """
  An audit log event identifier. See [Audit log events](https://discordapp.com/developers/docs/resources/audit-log#audit-log-entry-object-audit-log-events)
  """
  @type action_type :: pos_integer()

  @typep change_value :: String.t() | Snowflake.t() | Integer.t() | [map()] | boolean()

  @typedoc """
  Individual changes of this audit log entry.
  Change keys are documented [here](https://discordapp.com/developers/docs/resources/audit-log#audit-log-change-object-audit-log-change-key)
  """
  @type changes ::
          [
            %{
              optional(:old_value) => change_value,
              optional(:new_value) => change_value,
              :key => String.t()
            }
          ]
          | nil

  @typedoc "The ID of this entry"
  @type id :: Snowflake.t()

  @typedoc """
  [Optional audit entry info](https://discordapp.com/developers/docs/resources/audit-log#audit-log-entry-object-optional-audit-entry-info)
  """
  @type options :: Map.t() | nil

  @typedoc "The reason for this change, if applicable"
  @type reason :: String.t() | nil

  @typedoc "The ID of the affected entity"
  @type target_id :: String.t() | nil

  @typedoc "The user who made the changes"
  @type user_id :: User.id()

  @type t :: %__MODULE__{
          action_type: action_type,
          changes: changes,
          id: id,
          options: options,
          reason: reason,
          target_id: target_id,
          user_id: user_id
        }

  @doc false
  def to_struct(map) do
    new =
      map
      |> Map.new(fn {k, v} -> {Util.maybe_to_atom(k), v} end)
      |> Map.update(:id, nil, &Util.cast(&1, Snowflake))
      |> Map.update(:user_id, nil, &Util.cast(&1, Snowflake))

    struct(__MODULE__, new)
  end
end
