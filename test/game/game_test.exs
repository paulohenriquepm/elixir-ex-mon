defmodule ExMon.Game.GameTest do
  use ExUnit.Case

  alias ExMon.Entities.Player
  alias ExMon.Game.Game

  @player Player.build("Player", :random_move, :average_move, :heal_move)
  @computer Player.build("Computer", :random_move, :average_move, :heal_move)

  describe "start/2" do
    test "when starting the game with valid params, should return an :ok message" do
      assert {:ok, _pid} = Game.start(@computer, @player)
    end
  end

  describe "info/0" do
    test "when starting the game with valid params and getting the game info, should return the expected game info" do
      Game.start(@computer, @player)

      expected_game_info = %{
        computer: %Player{
          life: 100,
          moves: %{random_move: :random_move, average_move: :average_move, heal_move: :heal_move},
          name: "Computer"
        },
        player: %Player{
          life: 100,
          moves: %{random_move: :random_move, average_move: :average_move, heal_move: :heal_move},
          name: "Player"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_game_info
    end
  end

  describe "update/1" do
    test "when updating the game state, should return the updated game info" do
      Game.start(@computer, @player)

      expected_start_game_info = %{
        computer: %Player{
          life: 100,
          moves: %{random_move: :random_move, average_move: :average_move, heal_move: :heal_move},
          name: "Computer"
        },
        player: %Player{
          life: 100,
          moves: %{random_move: :random_move, average_move: :average_move, heal_move: :heal_move},
          name: "Player"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_start_game_info

      updated_game_info = %{
        computer: %Player{
          life: 85,
          moves: %{random_move: :random_move, average_move: :average_move, heal_move: :heal_move},
          name: "Computer"
        },
        player: %Player{
          life: 80,
          moves: %{random_move: :random_move, average_move: :average_move, heal_move: :heal_move},
          name: "Player"
        },
        status: :started,
        turn: :player
      }

      Game.update(updated_game_info)

      expected_update_game_info = %{updated_game_info | turn: :computer, status: :continue}

      assert Game.info() == expected_update_game_info
    end
  end

  describe "player/0" do
    test "when getting the player, should return the expected player" do
      Game.start(@computer, @player)

      expected_player = %Player{
        life: 100,
        moves: %{random_move: :random_move, average_move: :average_move, heal_move: :heal_move},
        name: "Player"
      }

      assert Game.player() == expected_player
    end
  end

  describe "turn/0" do
    test "when getting the turn, should return the expected turn" do
      Game.start(@computer, @player)

      expected_turn = :player

      assert Game.turn() == expected_turn
    end
  end

  describe "fetch_player/1" do
    test "when getting the player, should return the expected player" do
      Game.start(@computer, @player)

      expected_player = %Player{
        life: 100,
        moves: %{random_move: :random_move, average_move: :average_move, heal_move: :heal_move},
        name: "Player"
      }

      assert Game.fetch_player(:player) == expected_player
    end
  end
end
