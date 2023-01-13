defmodule MultiverseRobot do
	@moduledoc """
	Robot module will house all of the functions that pertain to the initial state of the robot and for processing all its movements.
	"""

	@doc """
		Process all input commands to determine the position of the robot in a grid of user defined x y limits and movements.
	"""
	def start_robot() do
		input =	IO.gets("Please enter the limits of the robots grid in the form 'X Y'\n")
		<<grid_x::binary-size(1), _::binary-size(1), grid_y::binary-size(1), _::bitstring>> = input
		IO.puts("You entered #{grid_x}, #{grid_y}")
		# Initial robot state
		#(2, 3, E) LFRFF
		input = IO.gets("Please enter the initial state of the robots in the form '(X, Y, Direction) Movements'\n")
		 |> String.replace("(", "")
		 |> String.replace(")", "")
		 |> String.replace(",", "")
		 |> String.replace(" ", "")
		 |> String.trim()
		 IO.inspect(input)
		<<pos_x::binary-size(1),pos_y::binary-size(1), direction::binary-size(1), movements::bitstring>> = input
		state = %{
			pos_x: String.to_integer(pos_x),
			pos_y: String.to_integer(pos_y),
			grid_max_x: String.to_integer(grid_x),
			grid_max_y: String.to_integer(grid_y),
			direction: direction,
			movements: movements,
			lost?: false
		}
		process_moves(movements, state)

	end

	def process_moves(<<0::0>>, state) do
		state = if state.pos_x > state.grid_max_x, do: %{state | lost?: true}, else: state
		state = if state.pos_y > state.grid_max_y, do: %{state | lost?: true}, else: state
		state
	end
	def process_moves(<<move::binary-size(1), rest::bitstring>>, state) do
		IO.inspect(state)
		state = case move do
			"L" -> %{state | pos_x: state.pos_x - 1}
			"R" -> %{state | pos_x: state.pos_x + 1}
			"F" -> %{state | pos_y: state.pos_y + 1}
			"B" -> %{state | pos_y: state.pos_y - 1}
		end
			process_moves(rest, state)
	end

end
