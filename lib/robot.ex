defmodule MultiverseRobot do
	@moduledoc """
	Robot module will house all of the functions that pertain to the initial state of the robot and for processing all its movements.
	"""

	@doc """
		Process all input commands to determine the position of the robot in a grid of user defined x y limits and movements.
		It calls the set_robot_grid/0 and set_robot_commands/0 functions to take user input.

		## Parameters
		To be able to test this function we need to provide a dummy state that isn't from the command line.
		- test? - Boolean, whether this function being used as a test or not
		- state - Map, the initial state of the robot
	"""
	@spec start_robot(boolean(), map()) :: map()
	def start_robot(test? \\ false, state \\ %{}) do
		state = case test? do
			true
				-> state
			false ->
				{grid_x, grid_y} = set_robot_grid()
				set_robot_state(grid_x, grid_y)

			end
		process_moves(state.movements, state)

	end

	@doc """
	set_robot_grid will ask the user to input two numbers that define the limits of the grid
	"""
	@spec set_robot_grid() :: tuple()
	def set_robot_grid() do
		input =	IO.gets("Please enter the limits of the robots grid in the form 'X Y'\n")
		<<grid_x::binary-size(1), _::binary-size(1), grid_y::binary-size(1), _::bitstring>> = input
		#IO.puts("You entered #{grid_x}, #{grid_y}")
		{grid_x, grid_y}
	end

	@doc """
	set_robot_state will ask the user to input two numbers that define the limits of the grid
	"""
	@spec set_robot_state(integer(), integer()) :: String.t()
	def set_robot_state(grid_x, grid_y) do
 		input = IO.gets("Please enter the initial state of the robots in the form '(X, Y, Direction) Movements'\n")
			|> String.replace("(", "")
			|> String.replace(")", "")
			|> String.replace(",", "")
			|> String.replace(" ", "")
			|> String.trim()

		<<pos_x::binary-size(1),pos_y::binary-size(1), direction::binary-size(1), movements::bitstring>>= input
			%{
			pos_x: pos_x,
			pos_y: pos_y,
			grid_max_x: grid_x,
			grid_max_y: grid_y,
			direction: direction,
			movements: movements,
			lost?: false
		}
	end

	@doc """
		process_moves takes in a bitstring with all of the moves inputted by the user
	"""
	@spec process_moves(bitstring(), map()) :: map()
	def process_moves(<<0::0>>, state) do
		result = cond do
			state.pos_y > state.grid_max_y -> true
			state.pos_x > state.grid_max_x -> true
			state.pos_x < 0 -> true
			state.pos_y < 0 -> true
			true -> false
		end
		%{state | lost?: result}
	end
	@spec process_moves(bitstring(), map()) :: map()
	def process_moves(<<move::binary-size(1), rest::bitstring>>, state) do
		state = case move do
			"L" -> %{state | pos_x: state.pos_x - 1}
			"R" -> %{state | pos_x: state.pos_x + 1}
			"F" -> %{state | pos_y: state.pos_y + 1}
			"B" -> %{state | pos_y: state.pos_y - 1}
		end
			process_moves(rest, state)
	end

end
