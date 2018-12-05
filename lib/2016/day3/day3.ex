defmodule AdventOfCode.Day3 do
  def input do
    "lib/2016/day3/input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&cleanup/1)
  end

  def part1 do
    input
    |> Enum.filter(&is_valid_triangle?/1)
    |> Enum.count()
  end

  def part2 do
    sides = input |> List.flatten()

    a = sides |> Enum.take_every(3)
    b = sides |> Enum.drop(1) |> Enum.take_every(3)
    c = sides |> Enum.drop(2) |> Enum.take_every(3)

    (a ++ b ++ c)
    |> Enum.chunk(3)
    |> Enum.filter(&is_valid_triangle?/1)
    |> Enum.count()
  end

  defp cleanup(line) do
    line
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  def is_valid_triangle?([a, b, c]) do
    is_valid_side?(a, [b, c]) && is_valid_side?(b, [a, c]) && is_valid_side?(c, [a, b])
  end

  defp is_valid_side?(side, remaining), do: Enum.sum(remaining) > side
end
