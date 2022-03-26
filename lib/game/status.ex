defmodule ExMon.Game.Status do
  alias ExMon.Entities.Player

  def print_round_message(%{status: :started} = info) do
    IO.puts("\n--------------------------The game is started--------------------------\n")
    IO.inspect(info)
  end

  def print_round_message(%{status: :game_over} = info) do
    IO.puts("\n--------------------------The game it's over--------------------------\n")
    IO.inspect(info)
  end

  def print_round_message(%{
        status: :continue,
        turn: next_player,
        player: %Player{life: player_life},
        computer: %Player{life: computer_life}
      }) do
    IO.puts("Player life: #{player_life}")
    IO.puts("Computer life: #{computer_life}")
    IO.puts("\n-----------------------It's #{next_player} turn-----------------------\n")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n------The Player attacked the Computer dealing #{damage} damage------\n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n------The Computer attacked the Player dealing #{damage} damage------\n")
  end

  def print_move_message(player, :heal, life) do
    IO.puts("\n--------The #{player} healed itself! New life points: #{life}--------\n")
  end

  def print_wrong_move_message(move) do
    IO.puts("\n------Invalid move: #{move}------\n")
  end
end
