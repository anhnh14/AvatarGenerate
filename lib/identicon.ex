defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello()
      :world

  """
  def hello do
    :world
  end

  def pick_color(image) do
    %Identicon.Image{hex:  [r, g, b | _tail]} = image
    %Identicon.Image{image | color: {r, g, b}}
  end

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end


  def mirror_row(row) do
    [first, second | _tail] = row

    row ++ [second, first]
  end

  def build_grid(image) do

    %Identicon.Image{hex: hex} = image
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}

  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
