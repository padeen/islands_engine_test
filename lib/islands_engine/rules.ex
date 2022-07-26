defmodule IslandsEngine.Rules do
  alias __MODULE__

  defstruct state: :initialized

  def new(), do: %Rules{}

  def check(%Rules{state: :initialized} = rules, :add_player),
    do: {:ok, %Rules{rules | state: :players_set}}

  def check(%Rules{state: :players_set} = rules, {:position_islands, player}), do: {:ok, rules}

  def check(_state, _action), do: :error
end
