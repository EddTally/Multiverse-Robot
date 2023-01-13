defmodule MultiverseRobotTest do
  use ExUnit.Case
  doctest MultiverseRobot

	import ExUnit.CaptureIO


  test "robot_example" do
    input = "2, 1\n(2, 1, N) LRFFFFFFFFFRBL"

		assert capture_io([input: input, capture_prompt: false], fn ->
			IO.write MultiverseRobot.start_robot()
		end) == "You entered 2, 1\n21NLRFFRBL"
  end
end
