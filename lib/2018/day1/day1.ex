defmodule AdventOfCode.Year2018.Day1 do
  def part1 do
    input()
    |> Enum.reduce(0, &process/2)
  end

  def process("+" <> frequency, sum), do: sum + String.to_integer(frequency)
  def process("-" <> frequency, sum), do: sum - String.to_integer(frequency)

  def input do
    "lib/2018/day1/input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
