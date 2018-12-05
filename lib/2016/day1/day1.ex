defmodule AdventOfCode.Day1 do
  def start do
    {_, destination, _} =
      Enum.reduce(input, {:north, {0, 0}, {:not_found, MapSet.new()}}, &instruction(&1, &2))

    destination
  end

  def instruction({rotate, amount}, {direction, {x, y}, visited}) do
    new_direction = turn(direction, rotate)
    new_position = move({x, y}, new_direction, amount)

    steps_taken = steps_between({x, y}, new_position, new_direction)
    new_visited = check_for_duplicate(visited, steps_taken)

    {
      new_direction,
      new_position,
      new_visited
    }
  end

  def steps_between({x, y}, {dest_x, dest_y}, :west) do
    x..dest_x
    |> Enum.map(fn new_x -> {new_x, y} end)
    |> tl()
  end

  def steps_between({x, y}, {dest_x, dest_y}, :north) do
    y..dest_y
    |> Enum.map(fn new_y -> {x, new_y} end)
    |> tl()
  end

  def steps_between({x, y}, {dest_x, dest_y}, :east) do
    x..dest_x
    |> Enum.map(fn new_x -> {new_x, y} end)
    |> tl()
  end

  def steps_between({x, y}, {dest_x, dest_y}, :south) do
    y..dest_y
    |> Enum.map(fn new_y -> {x, new_y} end)
    |> tl()
  end

  def check_for_duplicate({:not_found, visited}, steps_taken) do
    Enum.reduce_while(steps_taken, {:not_found, visited}, fn step, {_, acc} ->
      case MapSet.member?(acc, step) do
        true ->
          IO.puts("Duplicate found")
          IO.inspect(step)
          {:halt, {:found, acc}}

        false ->
          {:cont, {:not_found, MapSet.put(acc, step)}}
      end
    end)
  end

  def check_for_duplicate({:found, _}, _), do: {:found, %{}}

  def move({x, y}, :north, amount), do: {x, y + amount}
  def move({x, y}, :west, amount), do: {x - amount, y}
  def move({x, y}, :south, amount), do: {x, y - amount}
  def move({x, y}, :east, amount), do: {x + amount, y}

  def turn(:north, "L"), do: :west
  def turn(:north, "R"), do: :east
  def turn(:west, "L"), do: :south
  def turn(:west, "R"), do: :north
  def turn(:south, "L"), do: :east
  def turn(:south, "R"), do: :west
  def turn(:east, "L"), do: :north
  def turn(:east, "R"), do: :south

  def input do
    File.read!("lib/2016/day1/input.txt")
    |> String.split(", ")
    |> Enum.map(fn instruction ->
      {
        String.slice(instruction, 0, 1),
        String.slice(instruction, 1, 1500) |> String.trim() |> String.to_integer(10)
      }
    end)
  end
end
