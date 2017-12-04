defmodule AdventOfCode.TwentySeventeen.Day3 do

  @moduledoc """
  17  16  15  14  13
  18   5   4   3  12
  19   6   1   2  11
  20   7   8   9  10
  21  22  23---> ...
  """

  @goal 277_678

  @grid %{
    0 => %{0 => 1}
  }

  def part1 do
    2..@goal
    |> Enum.reduce({@grid, {0, 0}, :right}, fn(val, {grid, {x, y}, last_direction}) ->
      {new_x, new_y} = new_position({x, y}, last_direction)

      unless grid[new_x] do grid = Kernel.put_in(grid[new_x], %{}) end
      updated_grid = Kernel.put_in(grid[new_x][new_y], val)
      next_direction = choose_direction({new_x, new_y}, updated_grid, last_direction)

      {updated_grid, {new_x, new_y}, next_direction}
    end)
    |> elem(1)
    |> Tuple.to_list
    |> Enum.sum
  end

  def choose_direction({x, y}, grid, last_direction) do
    case last_direction do
      :right -> if grid[x][y-1], do: :right, else: :up
      :up -> if grid[x-1][y], do: :up, else: :left
      :left -> if grid[x][y+1], do: :left, else: :down
      :down -> if grid[x+1][y], do: :down, else: :right
    end
  end

  def new_position({x, y}, :right), do: {x+1, y}
  def new_position({x, y}, :up), do: {x, y-1}
  def new_position({x, y}, :left), do: {x-1, y}
  def new_position({x, y}, :down), do: {x, y+1}

  def part2 do
    2..@goal
    |> Enum.reduce_while({@grid, {0, 0}, :right}, fn(val, {grid, {x, y}, last_direction}) ->
      {new_x, new_y} = new_position({x, y}, last_direction)

      unless grid[new_x] do grid = Kernel.put_in(grid[new_x], %{}) end
      updated_value = new_value(grid, {new_x, new_y})

      updated_grid = Kernel.put_in(grid[new_x][new_y], updated_value)
      next_direction = choose_direction({new_x, new_y}, updated_grid, last_direction)

      if updated_value > @goal do
        {:halt, updated_value}
      else
        {:cont, {updated_grid, {new_x, new_y}, next_direction}}
      end
    end)
  end

  def new_value(grid, {x, y}) do
    sum = 0

    if grid[x-1][y], do: sum = sum + grid[x-1][y]
    if grid[x][y-1], do: sum = sum + grid[x][y-1]
    if grid[x+1][y], do: sum = sum + grid[x+1][y]
    if grid[x][y+1], do: sum = sum + grid[x][y+1]

    if grid[x-1][y-1], do: sum = sum + grid[x-1][y-1]
    if grid[x+1][y+1], do: sum = sum + grid[x+1][y+1]
    if grid[x-1][y+1], do: sum = sum + grid[x-1][y+1]
    if grid[x+1][y-1], do: sum = sum + grid[x+1][y-1]

    sum
  end
end
