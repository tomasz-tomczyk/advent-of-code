defmodule AdventOfCode.Year2018.Day2 do
  def part1 do
    [x, y] =
      input()
      |> Enum.map(&count_matches/1)
      |> Enum.reduce(%{}, fn x, acc -> Map.merge(x, acc, fn _k, v1, v2 -> v1 + v2 end) end)
      |> Map.values()

    x * y
  end

  def count_matches(string) do
    string
    |> String.graphemes()
    |> Enum.group_by(fn x -> x end)
    |> Enum.map(fn {_k, v} -> Enum.count(v) end)
    |> Enum.filter(fn x -> x in [2, 3] end)
    |> Enum.uniq()
    |> Enum.reduce(%{}, fn x, acc -> Map.put(acc, x, 1) end)
  end

  def input do
    "lib/2018/day2/input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
