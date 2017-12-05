defmodule AdventOfCode.TwentySeventeen.Day2 do
  def input do
    "lib/2017/day2/input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn(s) -> s |> String.split |> Enum.map(&String.to_integer/1) end)
  end

  def part1 do
    input
    |> Enum.map(fn(row) -> Enum.max(row) - Enum.min(row) end)
    |> Enum.sum
  end

  def part2 do
    input
    |> Enum.map(fn(row) ->
      out = for x <- row, y <- row, x != y, rem(x, y) == 0, do: div(x, y)
      hd(out)
    end)
    |> Enum.sum
  end
end
