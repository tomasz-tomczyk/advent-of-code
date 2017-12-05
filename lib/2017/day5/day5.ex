defmodule AdventOfCode.TwentySeventeen.Day5 do
  def input do
    "lib/2017/day5/input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1 do
    input
    |> get_next_value(0, 0)
  end

  def part2 do
    input
    |> get_next_value_part2(0, 0)
  end

  def get_next_value(list, position, steps) do
    if value = Enum.at(list, position) do
      list = List.update_at(list, position, &(&1 + 1))

      get_next_value(list, position + value, steps + 1)
    else
      IO.puts(steps)
    end
  end

  def get_next_value_part2(list, position, steps) do
    if value = Enum.at(list, position) do
      list = List.update_at(list, position, fn val -> if val >= 3, do: val - 1, else: val + 1 end)

      get_next_value_part2(list, position + value, steps + 1)
    else
      IO.puts(steps)
    end
  end
end
