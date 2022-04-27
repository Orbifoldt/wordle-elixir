# Wordle

[dictionary.txt](http://www.math.sjsu.edu/~foster/dictionary.txt)

To start IEx and compile the code run:
```bash
iex -S mix
```
Then start the game as follows:
```elixir
WordleGame.play()
```
You will be prompted for you guesses, try to guess the word before you run out of tries, good luck! 
> Note that Windows can't deal with emoji, even iex in PowerShell 7 seems to have trouble with printing simple UTF8 encoded strings. For the optimal experience use some other shell.

## Testing

To run the tests
```bash
mix test
```


<!-- ## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `wordle` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:wordle, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/wordle>. -->

