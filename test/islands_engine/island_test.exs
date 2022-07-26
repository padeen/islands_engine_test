defmodule IslandsEngine.IslandTest do
  use ExUnit.Case

  alias IslandsEngine.{Coordinate, Island}

  setup_all do
    {:ok, valid_coordinate} = Coordinate.new(4, 1)
    %{valid_coordinate: valid_coordinate}
  end

  describe "create island" do
    test "creating island with valid type and valid coordinate should create island", %{
      valid_coordinate: valid_coordinate
    } do
      {:ok, %Island{}} = Island.new(:square, valid_coordinate)
    end

    test "coordinates should not be empty for valid island", %{valid_coordinate: valid_coordinate} do
      {:ok, square} = Island.new(:square, valid_coordinate)
      assert not Enum.empty?(square.coordinates)
    end

    test "creating island with coordinate off board should return error" do
      {:ok, coordinate} = Coordinate.new(10, 1)
      {:error, :invalid_coordinate} = Island.new(:square, coordinate)
    end

    test "creating island with invalid type should return error", %{
      valid_coordinate: valid_coordinate
    } do
      {:error, :invalid_island_type} = Island.new(:wrong_island_type, valid_coordinate)
    end
  end

  describe "guess/2" do
    test "guessing islands coordinate adds coordinate to island hits", %{
      valid_coordinate: valid_coordinate
    } do
      {:ok, square} = Island.new(:square, valid_coordinate)
      {:hit, square_after_hit} = Island.guess(square, valid_coordinate)
      Enum.member?(square_after_hit.hit_coordinates, valid_coordinate)
    end

    test "guessing non island coordinate returns miss", %{valid_coordinate: valid_coordinate} do
      non_island_coordinate = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, valid_coordinate)
      :miss = Island.guess(square, non_island_coordinate)
    end
  end

  describe "forested/1" do
    test "all islands coordinates hit should return true", %{valid_coordinate: valid_coordinate} do
      {:ok, square} = Island.new(:square, valid_coordinate)
      {:ok, coordinate1} = Coordinate.new(4, 1)
      {:ok, coordinate2} = Coordinate.new(5, 1)
      {:ok, coordinate3} = Coordinate.new(4, 2)
      {:ok, coordinate4} = Coordinate.new(5, 2)

      {:hit, square_after_hit} = Island.guess(square, coordinate1)
      {:hit, square_after_hit} = Island.guess(square_after_hit, coordinate2)
      {:hit, square_after_hit} = Island.guess(square_after_hit, coordinate3)
      {:hit, square_after_hit} = Island.guess(square_after_hit, coordinate4)

      true = Island.forested?(square_after_hit)
    end

    test "not all islands coordinates hit should return false", %{
      valid_coordinate: valid_coordinate
    } do
      {:ok, square} = Island.new(:square, valid_coordinate)
      {:ok, coordinate1} = Coordinate.new(4, 1)
      {:ok, coordinate2} = Coordinate.new(5, 1)

      {:hit, square_after_hit} = Island.guess(square, coordinate1)
      {:hit, square_after_hit} = Island.guess(square_after_hit, coordinate2)

      false = Island.forested?(square_after_hit)
    end
  end
end
