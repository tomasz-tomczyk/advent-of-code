defmodule AdventOfCode.Day3 do

  def start do
    {:ok, contents} = File.read("../day3/input.txt")

    contents
    |> String.split("\n", trim: true)
    |> Enum.map(&cleanup/1)
    |> Enum.filter(&is_valid_triangle?/1)
    |> Enum.count
  end

  defp cleanup(line) do
    line
    |> String.split
    |> Enum.map(&String.to_integer/1)
  end

  def is_valid_triangle?([a, b, c]) do
    is_valid_side?(a, [b, c]) &&
      is_valid_side?(b, [a, c]) &&
      is_valid_side?(c, [a, b])
  end

  defp is_valid_side?(side, remaining), do: Enum.sum(remaining) > side

end
