defmodule AdventOfCode.TwentySeventeen.Day1 do
  def part1 do
    input
    |> (fn(list) -> list ++ Enum.take(list, 1) end).()
    |> Enum.reduce({0, nil},
      fn(current_number, {sum, last_number}) ->
        case last_number == current_number do
          true -> {sum + current_number, current_number}
          _ -> {sum, current_number}
        end
      end
    )
    |> elem(0)
  end

  def part2 do
    offset = round(Enum.count(input) / 2)

    input
    |> Enum.reduce_while({0, 0},
      fn(current_number, {sum, position}) ->
        if position < offset do
          case current_number == Enum.at(input, position + offset) do
            true -> {:cont, {sum + current_number, position + 1}}
            _ -> {:cont, {sum, position + 1}}
          end
        else
          {:halt, {sum, position + 1}}
        end
      end
    )
    |> elem(0)
    |> Kernel.*(2)
  end

  def input do
    "lib/2017/day1/input.txt"
    |> File.read!()
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
