defmodule ExMon.Game.Moves.Heal do
  alias ExMon.Game.{Game, Status}

  @heal_power 18..25

  def heal_life(current_player) do
    current_player
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_new_life()
    |> update_player_life(current_player)
  end

  defp calculate_new_life(life), do: Enum.random(@heal_power) + life

  defp update_player_life(life, current_player) when life > 100,
    do: update_game(current_player, 100)

  defp update_player_life(life, current_player), do: update_game(current_player, life)

  def update_game(current_player, updated_life) do
    current_player
    |> Game.fetch_player()
    |> Map.put(:life, updated_life)
    |> update_game(current_player, updated_life)
  end

  defp update_game(updated_player, current_player, updated_life) do
    Game.info()
    |> Map.put(current_player, updated_player)
    |> Game.update()

    Status.print_move_message(current_player, :heal, updated_life)
  end
end
