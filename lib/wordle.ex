defmodule Wordle do
  @moduledoc """
  Documentation for `Wordle`.
  """


  @doc """
  Calculates the score of a guess in a game of Wordle.

  Given a guess, each letter is marked as either green, yellow or grey:
  - green indicates that letter is correct and in the correct position,
  - yellow means it is in the answer but not in the right position,
  - while grey indicates it is not in the answer at all.

  Multiple instances of the same letter in a guess, such as the "o"s in "robot", will be colored green or yellow only if the letter also appears multiple times in the answer; otherwise, excess repeating letters will be colored grey.

  In the scoring, a correct letter in the correct position takes precedence over a correct letter in an incorrect position.

  ## Examples

      iex> Wordle.score("ALLOW", "LOLLY")
      [:yellow, :yellow, :green, :grey, :grey]

      iex> Wordle.score("BULLY", "LOLLY")
      [:grey, :grey, :green, :green, :green]

      iex> Wordle.score("ROBIN", "ALERT")
      [:grey, :grey, :grey, :yellow, :grey]

      iex> Wordle.score("ROBIN", "SONIC")
      [:grey, :green, :yellow, :green, :grey]

      iex> Wordle.score("ROBIN", "ROBIN")
      [:green, :green, :green, :green, :green]

  """
  @spec score(binary, binary) :: [:green | :yellow | :grey]
  def score(target, guess) do
    zip_graphemes(target, guess)
      |> score_greens
      |> accumulate_remaining_letters
      |> score_yellows
  end

  defp zip_graphemes(string1, string2), do: Enum.zip(String.graphemes(string1), String.graphemes(string2))

  @spec score_greens([{String.grapheme, String.grapheme}]) :: [:green | {String.grapheme, String.grapheme}]
  defp score_greens([]), do: []
  defp score_greens([{x,x} | tail]), do: [:green | score_greens(tail)]
  defp score_greens([{x,y} | tail]), do: [{x,y} | score_greens(tail)]

  @spec accumulate_remaining_letters([:green | {String.grapheme, String.grapheme}]) :: {[String.grapheme], [:green | String.grapheme]}
  defp accumulate_remaining_letters(res) do
    res |> Enum.reverse
     |> Enum.reduce({[],[]}, &prepend_target_and_guess/2)
  end

  defp prepend_target_and_guess(:green, {remaining, guesses}), do: {remaining, [:green | guesses]}
  defp prepend_target_and_guess({target_char, guessed_char}, {remaining, guesses}) do
    {[target_char | remaining], [guessed_char | guesses]}
  end

  @spec score_yellows({[String.grapheme], [:green | String.grapheme]}) :: [:green | :yellow | :grey]
  defp score_yellows({_, []}), do: []
  defp score_yellows({remaining_target, [:green | tail]}), do: [:green | score_yellows({remaining_target, tail})]
  defp score_yellows({remaining_target, [guess_char | tail]}) do
    if(Enum.member?(remaining_target, guess_char)) do
      [:yellow | score_yellows({List.delete(remaining_target, guess_char), tail})]
    else
      [:grey |  score_yellows({remaining_target, tail})]
    end
  end

end
