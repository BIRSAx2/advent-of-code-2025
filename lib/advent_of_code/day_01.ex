defmodule AdventOfCode.Day01 do
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      {direction, distance} = String.split_at(line, 1)

      case direction do
        "L" -> -String.to_integer(distance)
        "R" -> String.to_integer(distance)
      end
    end)
  end

  def part1(args) do
    args
    |> parse()
    |> Enum.reduce([50], fn step, acc ->
      [head | _] = acc
      [Integer.mod(head + step, 100) | acc]
    end)
    |> Enum.count(&(&1 == 0))
  end

  def part2(args) do
    args
    |> parse()
    |> Enum.reduce({50, 0}, fn offset, {current, count} ->
      next = offset + current
      incr = abs(div(next, 100)) + if current != 0 && next <= 0, do: 1, else: 0
      {Integer.mod(next, 100), count + incr}
    end)
    |> elem(1)
  end
end
