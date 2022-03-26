defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Entities.Player

  describe "create_player/4" do
    test "when creating a player, should return the expected player struct" do
      expected_player_struct = %Player{
        life: 100,
        moves: %{average_move: :average_move, random_move: :random_move, heal_move: :heal_move},
        name: "Player"
      }

      assert ExMon.create_player("Player", :random_move, :average_move, :heal_move) ==
               expected_player_struct
    end
  end

  describe "start_game/1" do
    test "when starting a game, should return the started game message" do
      player = Player.build("Player", :random_move, :average_move, :heal_move)

      messages = capture_io(fn -> ExMon.start_game(player) end)

      assert messages =~ "The game is started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Player", :random_move, :average_move, :heal_move)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when making a valid move, should make the player move and the computer move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:average_move)
        end)

      assert messages =~ "The Player attacked the Computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
    end

    test "when making an invalid move, should returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:invalid_move)
        end)

      assert messages =~ "Invalid move: invalid_move"
    end
  end
end
