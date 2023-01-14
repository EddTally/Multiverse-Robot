# MultiverseRobot

## Instructions to run

To run type iex -S mix at the base of this folder and then run MultiverseRobot.start_robot().

To run the tests just type `mix test` from the console not inside iex. 

## To Do
Fulfil these requirement of the challenge:
Each robot can move forward one space (F), rotate left by 90 degrees (L), or rotate right by 90 degrees (R).
Currently I have not setup a check to see if the commands turn more than 90 degrees as I was nearing the time limit.

If a robot moves off the grid, it is marked as ‘lost’ and its last valid grid position and orientation is recorded.
Currently I am not using it's last valid position, I am processing all the positions and then checking if its a valid position, this could easily be achieved by adding a when guard to the function and checking each time.

Write more tests for edge cases.
Capture output of set_robot_grid() and set_robot_state()

## Future Possibilities
If multiple commands are to be issued to multiple robots instead of in one long string to one robot then it might be prudent to use genservers to keep the state of each individual robot.