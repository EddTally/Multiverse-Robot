defmodule MultiverseRobotTest do
  alias ExUnit.CaptureIO
  use ExUnit.Case
  doctest MultiverseRobot

	import ExUnit.CaptureIO

	@full_example_input "2, 1\n(2, 1, N) LRFFFFFFFFFRBL"

  test "robot_example" do
		state = %{
			pos_x: 2,
			pos_y: 1,
			grid_max_x: 5,
			grid_max_y: 6,
			direction: N,
			movements: "LRFFFFFFFFFRBL",
			lost?: false
		}

		assert MultiverseRobot.start_robot(true, state) ==
			%{
  			direction: N,
  			grid_max_x: 5,
  			grid_max_y: 6,
  			lost?: true,
  			movements: "LRFFFFFFFFFRBL",
  			pos_x: 2,
  			pos_y: 9
			}
  end

	test "robot grid setup" do
		assert CaptureIO.capture_io("2 1", fn ->
			MultiverseRobot.set_robot_grid()
		end) =="Please enter the limits of the robots grid in the form 'X Y'\n"

		# We don't care about the prompt on this one only the output
		# assert CaptureIO.capture_io([input: "2 1", capture_prompt: false], fn ->
		# 	MultiverseRobot.set_robot_grid()
		# end) =={2, 1}
	end

	test "robot state setup" do
		assert CaptureIO.capture_io("(2, 1, N) LRFFFFFFFFFRBL", fn ->
			MultiverseRobot.set_robot_state(2, 1)
		end) =="Please enter the initial state of the robots in the form '(X, Y, Direction) Movements'\n"

	end
end
