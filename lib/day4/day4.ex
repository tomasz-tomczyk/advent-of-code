defmodule AdventOfCode.Day4 do

  def part1 do
    File.read!("../day4/input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&room/1)
    |> Enum.map(fn({sector, checksum, calculated_checksum}) ->
      case calculated_checksum == checksum do
        true -> sector
        _ -> 0
      end
    end)
    |> Enum.sum
  end

  def room(line) do
    split = line |> String.split("-")

    [checksum, sector] = Regex.named_captures(~r{((?<sector>[0-9]+)\[(?<checksum>[a-z]+)\])}, List.last(split))
    |> Map.values

    calculated_checksum = split
    |> Enum.drop(-1)
    |> calculate_checksum

    {sector |> String.to_integer, checksum, calculated_checksum}
  end

  defp calculate_checksum(strings) do
    strings
    |> Enum.reduce(%{}, fn(string, acc) ->
      count_characters(string, acc)
    end)
    |> Enum.sort(&sorter/2)
    |> Enum.take(5)
    |> Enum.reduce([], fn({key, _}, acc) -> acc ++ [key] end)
    |> List.flatten
    |> List.to_string
  end

  defp sorter({key1, val1}, {key2, val2}) do
    cond do
      val1 == val2 -> key1 < key2
      val1 > val2 -> true
      val2 > val1 -> false
    end
  end

  defp count_characters(string, acc) do
    string
    |> String.split("", trim: true)
    |> Enum.reduce(acc, fn(char, accumulator) ->
      Map.update(accumulator, char, 1, &(&1 + 1))
    end)
  end

end
