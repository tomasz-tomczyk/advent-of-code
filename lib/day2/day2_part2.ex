defmodule AdventOfCode.Day2_Part2 do

  @keypad %{
    {2, 0} => 1,
    {1, 1} => 2,
    {2, 1} => 3,
    {3, 1} => 4,
    {0, 2} => 5,
    {1, 2} => 6,
    {2, 2} => 7,
    {3, 2} => 8,
    {4, 2} => 9,
    {1, 3} => "A",
    {2, 3} => "B",
    {3, 3} => "C",
    {2, 4} => "D"
  }

  def start do
    {:ok, contents} = File.read("../day2/input.txt")

    {_, entry_code} = contents
    |> String.split("\n", trim: true)
    |> Enum.reduce({{0, 2}, []}, fn(instructions, {{x, y}, combination}) ->
      {x, y} = instructions
      |> String.split("", trim: true)
      |> Enum.map(&String.to_atom(&1))
      |> Enum.reduce({x, y}, fn(instruction, {curr_x, curr_y}) ->
        move({curr_x, curr_y}, instruction)
      end)

      {{x, y}, combination ++ [@keypad[{x, y}]]}
    end)

    entry_code
    |> Enum.join("")
  end

  def move({x, y}, :R) do
    case Map.has_key?(@keypad, {x + 1, y}) do
      true -> {x + 1, y}
      _ -> {x, y}
    end
  end
  def move({x, y}, :L) do
    case Map.has_key?(@keypad, {x - 1, y}) do
      true -> {x - 1, y}
      _ -> {x, y}
    end
  end
  def move({x, y}, :D) do
    case Map.has_key?(@keypad, {x, y + 1}) do
      true -> {x, y + 1}
      _ -> {x, y}
    end
  end
  def move({x, y}, :U) do
    case Map.has_key?(@keypad, {x, y - 1}) do
      true -> {x, y - 1}
      _ -> {x, y}
    end
  end
end
