defmodule Day1 do

  def start do
    Enum.reduce(input, {:north, {0, 0}}, &instruction(&1, &2))
  end

  def instruction({rotate, amount}, {direction, {x, y}}) do
    new_direction = turn(direction, rotate)

    {
      new_direction,
      move({x, y}, new_direction, amount)
    }
  end

  def move({x, y}, :north, amount), do: {x, y+amount}
  def move({x, y}, :west, amount), do: {x-amount, y}
  def move({x, y}, :south, amount), do: {x, y-amount}
  def move({x, y}, :east, amount), do: {x+amount, y}

  def turn(:north, "L"), do: :west
  def turn(:north, "R"), do: :east
  def turn(:west, "L"), do: :south
  def turn(:west, "R"), do: :north
  def turn(:south, "L"), do: :east
  def turn(:south, "R"), do: :west
  def turn(:east, "L"), do: :north
  def turn(:east, "R"), do: :south

  def input do
    {:ok, contents} = File.read("../input.txt")

    contents
    |> String.split(", ")
    |> Enum.map(fn(instruction) ->
      {
        String.slice(instruction, 0, 1),
        String.slice(instruction, 1, 1500) |> String.trim |> String.to_integer(10),
      }
    end)
  end

end
