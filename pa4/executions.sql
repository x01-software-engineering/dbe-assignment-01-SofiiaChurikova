-- This procedure provides full information based on given team ID
CALL get_players_by_team_id_sproc(2);


-- This procedure provides full information about goals based on given player
CALL get_player_goals_sproc('Virgil van Dijk', @total_goals);
SELECT @total_goals;


-- This procedure updates player's number
SET @player_id = 43;
CALL update_player_number_sproc(@player_id, 15);


-- It's update manager's name if team didn't score a goal, otherwise changes are cancelled 
CALL update_team_manager_sproc(1, 'New manager');
SELECT * FROM teams;


-- It's update player's position to 'Substitute' if player's age > 36
CALL update_player_position_sproc();
SELECT * FROM players;
