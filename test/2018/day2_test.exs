defmodule AdventOfCode.Year2018.Day2Test do
  use ExUnit.Case

  test "Repeated matches correctly counted" do
    assert AdventOfCode.Year2018.Day2.count_matches("abcdef") == %{}

    assert AdventOfCode.Year2018.Day2.count_matches("bababc") == %{
             2 => 1,
             3 => 1
           }

    assert AdventOfCode.Year2018.Day2.count_matches("abbcde") == %{2 => 1}
    assert AdventOfCode.Year2018.Day2.count_matches("abcccd") == %{3 => 1}
    assert AdventOfCode.Year2018.Day2.count_matches("aabcdd") == %{2 => 1}
    assert AdventOfCode.Year2018.Day2.count_matches("abcdee") == %{2 => 1}
    assert AdventOfCode.Year2018.Day2.count_matches("ababab") == %{3 => 1}

    assert AdventOfCode.Year2018.Day2.part1() == 6370
  end
end
