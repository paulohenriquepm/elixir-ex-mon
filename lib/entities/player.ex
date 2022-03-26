defmodule ExMon.Entities.Player do
  @keys [:life, :name, :moves]
  @max_life 100

  @enforce_keys @keys

  defstruct @keys

  def build(name, random_move, average_move, heal_move) do
    %ExMon.Entities.Player{
      life: @max_life,
      moves: %{
        random_move: random_move,
        average_move: average_move,
        heal_move: heal_move
      },
      name: name
    }
  end
end
