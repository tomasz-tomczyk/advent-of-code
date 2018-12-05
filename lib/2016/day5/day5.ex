defmodule AdventOfCode.Day5 do

  @input "uqwqemis"

  def part1 do
    start = :os.system_time(:seconds)

    Stream.resource(
      fn -> 1 end,
      fn(index) ->
        {[get_character(@input, index)], index + 1}
      end,
      fn(num) -> num end
    )
    |> Stream.filter(fn(val) -> !is_nil(val) end)
    |> Enum.take(8)
    |> IO.inspect

    :os.system_time(:seconds) - start
  end

  def time do
    start = :os.system_time(:seconds)

    Stream.resource(
      fn -> 1 end,
      fn(index) ->
        cond do
          index < 10000000 -> {[hash(@input, index)], index + 1}
          true -> {:halt, "test"}
        end
      end,
      fn(num) -> num end
    )
    |> Enum.into([])

    :os.system_time(:seconds) - start
  end

  def time2 do
    start = :os.system_time(:seconds)

    Enum.map(1..10000000, fn x -> hash(x) end)

    :os.system_time(:seconds) - start
  end

  def hash(index) do
    :erlang.md5(index |> Integer.to_string) |> Base.encode16(case: :lower)
  end

  def part2 do
    start = :os.system_time(:seconds)

    Stream.resource(
      fn -> 1 end,
      fn(index) ->
        {[get_character_position(@input, index)], index + 1}
      end,
      fn(num) -> num end
    )
    |> Stream.filter(fn(val) -> !is_nil(val) end)
    |> Enum.reduce_while(%{}, fn({position, char}, password) ->
      new_password = create_password(position, char, password)

      cond do
        Map.keys(new_password) |> length < 8 ->
          {:cont, new_password}
        true -> {:halt, new_password}
      end
    end)
    |> Map.values
    |> List.to_string
    |> IO.inspect

    :os.system_time(:seconds) - start
  end

  def create_password(position, char, password) when is_integer(position) and position < 8, do: Map.put_new(password, position, char)
  def create_password(position, char, password), do: password

  def get_character_position(id, index, offset \\ 5) do
    hash = hash(id, index)
    case Regex.match?(~r/^00000/, hash) do
      true ->
        rest = hash |> String.split("") |> Enum.drop(offset)

        case Enum.at(rest, 0) |> Integer.parse do
          :error -> nil
          {pos, _} -> {pos, Enum.at(rest, 1)}
        end
      _  -> nil
    end
  end

  def get_character(id, index, offset \\ 5) do
    hash = hash(id, index)
    case Regex.match?(~r/^00000/, hash) do
      true -> hash |> String.to_charlist |> Enum.drop(offset) |> List.first
      _  -> nil
    end
  end

  def hash(id, index) do
    :erlang.md5("#{id}#{index}") |> Base.encode16(case: :lower)
  end

end
