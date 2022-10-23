defmodule WordleTest do
  use ExUnit.Case
  doctest Wordle


  test "letter on correct place gives green" do
    target = "BAAAA"
    guess = "BZZZZ"
    score = Wordle.score(target, guess)

    assert Enum.at(score, 0) == :green
  end

  test "correct letter but in wrong place gives yellow" do
    target = "BAAAA"
    guess = "ZBZZZ"
    score = Wordle.score(target, guess)

    assert Enum.at(score, 1) == :yellow
  end

  test "incorrect letter gives grey" do
    target = "AAAAA"
    guess = "ZZZZZ"
    score = Wordle.score(target, guess)

    assert Enum.at(score, 0) == :grey
  end

  test "none correct should give all grey" do
    target = "AAAAA"
    guess = "ZZZZZ"
    score = Wordle.score(target, guess)

    assert score == List.duplicate(:grey, 5)
  end

  test "all correct should give all green" do
    target = "ABCDE"
    guess = "ABCDE"
    score = Wordle.score(target, guess)

    assert score == List.duplicate(:green, 5)
  end

  test "all correct but none in right position gives all yellow" do
    target = "ABCDE"
    guess = "BCDEA"
    score = Wordle.score(target, guess)

    assert score == List.duplicate(:yellow, 5)
  end

  test "repeated guessed letter with only a single one matching should return a single green" do
    target = "ABBBB"
    guess = "AAZZZ"
    score = Wordle.score(target, guess)

    assert score == [:green, :grey, :grey, :grey, :grey]
  end

  test "repeated guessed letter on wrong places with only one correct should return a single yellow" do
    target = "ABBBB"
    guess = "ZAAZZ"
    score = Wordle.score(target, guess)

    assert score == [:grey, :yellow, :grey, :grey, :grey]
  end

  test "repeated guessed letter with second one correctly placed should return single green for the second letter" do
    target = "BABBB"
    guess = "AAZZZ"
    score = Wordle.score(target, guess)

    assert score == [:grey, :green, :grey, :grey, :grey]
  end

  test "trice repeated letter with one correct location and one correct but incorrect location gives 1 green and 1 yellow" do
    target = "BBBAA"
    guess = "AZAZA"
    score = Wordle.score(target, guess)

    assert score == [:yellow, :grey, :grey, :grey, :green]
  end

  # test "unequal lengths" do
  #   target = "BBBAA"
  #   guess = "AZAZAAA"
  #   score = Wordle.score(target, guess)

  #   assert score == {:error, :unequal_length}
  # end


end
