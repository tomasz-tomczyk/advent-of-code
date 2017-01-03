defmodule AdventOfCode.Day4 do

  def part1 do
    File.read!("../day4/input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&room/1)
    |> Enum.map(fn({_, sector, checksum, calculated_checksum}) ->
      case calculated_checksum == checksum do
        true -> sector
        _ -> 0
      end
    end)
    |> Enum.sum
  end

  def part2 do
    File.read!("../day4/input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&room/1)
    |> Enum.map(&decrypt/1)
    |> Enum.map(fn({name, sector}) ->
      case Regex.match?(~r/north/, name) do
        true -> sector
        _ -> nil
      end
    end)
    |> Enum.sort
    |> List.first
    |> IO.inspect
  end

  def decrypt({name, sector, _, _}) do
    offset = sector |> rem(26)

    decrypted = name
    |> String.graphemes
    |> Enum.map(&(decrypt_char(&1, offset)))
    |> List.to_string

    {decrypted, sector}
  end

  defp decrypt_char("-", _), do: " "
  defp decrypt_char(<<letter>>, offset) do
    <<?a + rem((letter - ?a) + offset, 26)>>
  end

  def room(line) do
    split = line |> String.split("-")

    [checksum, sector] = Regex.named_captures(~r{((?<sector>[0-9]+)\[(?<checksum>[a-z]+)\])}, List.last(split))
    |> Map.values

    calculated_checksum = split
    |> Enum.drop(-1)
    |> calculate_checksum

    {line, sector |> String.to_integer, checksum, calculated_checksum}
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
