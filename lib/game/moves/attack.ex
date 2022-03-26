defmodule ExMon.Game.Moves.Attack do
  alias ExMon.Game.Game
  alias ExMon.Game.Status

  @average_move_damage 18..25
  @random_move_damage 10..35

  @spec attack_opponent(any, :average_move | :random_move) :: :ok
  def attack_opponent(opponent, move) do
    damage = calculate_power_damage(move)

    opponent
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_new_life(damage)
    |> update_opponent_life(opponent, damage)
  end

  defp calculate_power_damage(:average_move), do: Enum.random(@average_move_damage)
  defp calculate_power_damage(:random_move), do: Enum.random(@random_move_damage)

  defp calculate_new_life(life, damage) when life - damage < 0, do: 0
  defp calculate_new_life(life, damage), do: life - damage

  defp update_opponent_life(life, opponent, damage) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(opponent, damage)
  end

  defp update_game(updated_player, opponent, damage) do
    Game.info()
    |> Map.put(opponent, updated_player)
    |> Game.update()

    Status.print_move_message(opponent, :attack, damage)
  end
end
