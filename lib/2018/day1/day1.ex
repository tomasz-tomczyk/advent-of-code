defmodule AdventOfCode.Year2018.Day1 do
  def part1 do
    input()
    |> Enum.reduce(0, &process/2)
  end

  def part2 do
    {0, MapSet.new([0])}
    |> loop(input())
  end

  def loop({sum, frequencies_seen}, input) do
    input
    |> Enum.reduce_while({sum, frequencies_seen}, fn current_frequency, {sum, frequencies_seen} ->
      new_frequency = process(current_frequency, sum)

      case MapSet.member?(frequencies_seen, new_frequency) do
        true ->
          {:halt, new_frequency}

        false ->
          {:cont, {new_frequency, MapSet.put(frequencies_seen, new_frequency)}}
      end
    end)
    |> loop(input)
  end

  def loop(sum, _input), do: sum

  def process("+" <> frequency, sum), do: sum + String.to_integer(frequency)
  def process("-" <> frequency, sum), do: sum - String.to_integer(frequency)

  def input do
    "lib/2018/day1/input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
