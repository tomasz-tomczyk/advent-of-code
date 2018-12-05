defmodule AdventOfCode.Day6 do
  def input do
    "lib/2016/day6/input.txt"
    |> File.stream!()
    |> Stream.map(&String.strip/1)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> List.zip()
    |> Enum.map(fn chars ->
      chars
      |> Tuple.to_list()
      |> Enum.reduce(%{}, fn char, acc ->
        Map.update(acc, char, 1, &(&1 + 1))
      end)
      |> Enum.sort_by(fn {_, count} -> count end)
    end)
  end

  def part1 do
    input
    |> Enum.map(fn chars ->
      chars |> List.last() |> Tuple.to_list() |> List.first()
    end)
    |> Enum.join("")
  end

  def part2 do
    input
    |> Enum.map(fn chars ->
      chars |> List.first() |> Tuple.to_list() |> List.first()
    end)
    |> Enum.join("")
  end
end
