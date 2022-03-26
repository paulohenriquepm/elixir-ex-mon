defmodule ExMon.Game.Actions do
  alias ExMon.Game.Game
  alias ExMon.Game.Moves.{Attack, Heal}

  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move)
  end

  def find_move(moves, move_to_find) do
    Enum.find_value(moves, {:error, move_to_find}, fn {key, value} ->
      if value == move_to_find, do: {:ok, key}
    end)
  end

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end

  def heal do
    case Game.turn() do
      :player -> Heal.heal_life(:player)
      :computer -> Heal.heal_life(:computer)
    end
  end
end
