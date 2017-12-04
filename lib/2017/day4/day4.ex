defmodule AdventOfCode.TwentySeventeen.Day4 do

  def input do
    "lib/2017/day4/input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
  end

  def part1 do
    input
    |> Enum.filter(fn(row) ->
      row == Enum.uniq(row)
    end)
    |> Enum.count
  end

  def part2 do
    input
    |> Enum.map(&split_up_row/1)
    |> Enum.filter(fn(row) ->
      row == Enum.uniq(row)
    end)
    |> Enum.count
  end

  defp split_up_row(row) do
    row
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(&Enum.sort/1)
  end
end
