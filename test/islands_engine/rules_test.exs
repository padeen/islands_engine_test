defmodule IslandsEngine.RulesTest do
  use ExUnit.Case

  alias IslandsEngine.Rules

  setup_all do
    rules = Rules.new()
    %{rules: rules}
  end

  describe "new rules" do
    test "new rules starts with state initialized", %{rules: rules} do
      %Rules{state: :initialized} = rules
    end

    test "state initialized transitions to new state players_set", %{rules: rules} do
      {:ok, %Rules{state: :players_set}} = Rules.check(rules, :add_player)
    end

    test "only valid action is add_player", %{rules: rules} do
      :error = Rules.check(rules, :any_other_action)
    end
  end
end
