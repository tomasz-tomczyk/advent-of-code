defmodule AdventOfCode.Year2018.Day1Test do
  use ExUnit.Case

  test "Day 1 part 1 returns correct number" do
    assert AdventOfCode.Year2018.Day1.part1(["+1", "+1", "+1"]) == 3
    assert AdventOfCode.Year2018.Day1.part1(["+1", "-2", "+1"]) == 0
    assert AdventOfCode.Year2018.Day1.part1() == 569
  end

  test "Day 1 part 2 returns correct number" do
    assert AdventOfCode.Year2018.Day1.part2(["+1", "-1"]) == 0
    assert AdventOfCode.Year2018.Day1.part2(["+1", "+1", "-1"]) == 1
    assert AdventOfCode.Year2018.Day1.part2() == 77666
  end
end
