defmodule IslandsEngine.CoordinateTest do
  use ExUnit.Case

  alias IslandsEngine.Coordinate

  describe "create coordinate" do
    test "create coordinate with valid row and col should create coordinate" do
      {:ok, coordinate} = Coordinate.new(4, 1)
      %Coordinate{row: 4, col: 1} = coordinate
    end

    test "create coordinate with invalid row and col should create error message" do
      {:error, :invalid_coordinate} = Coordinate.new(11, 11)
    end
  end
end
