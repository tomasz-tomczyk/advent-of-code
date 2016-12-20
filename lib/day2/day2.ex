defmodule AdventOfCode.Day2 do

  @keypad %{
    {0, 0} => 1,
    {1, 0} => 2,
    {2, 0} => 3,
    {0, 1} => 4,
    {1, 1} => 5,
    {2, 1} => 6,
    {0, 2} => 7,
    {1, 2} => 8,
    {2, 2} => 9
  }

  def start do
    {:ok, contents} = File.read("../day2/input.txt")

    {_, entry_code} = contents
    |> String.split("\n", trim: true)
    |> Enum.reduce({{1,1}, []}, fn(instructions, {{x, y}, combination}) ->
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

  def move({x, y}, :R) when x < 2, do: {x + 1, y}
  def move({x, y}, :L) when x > 0, do: {x - 1, y}
  def move({x, y}, :D) when y < 2, do: {x, y + 1}
  def move({x, y}, :U) when y > 0, do: {x, y - 1}
  def move({x, y}, _), do: {x, y}
end
