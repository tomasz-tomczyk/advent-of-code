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
