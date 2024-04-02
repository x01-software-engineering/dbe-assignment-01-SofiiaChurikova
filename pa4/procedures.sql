-- procedure with IN
-- This procedure provides full information based on given team ID
DELIMITER //

CREATE PROCEDURE GetPlayersByTeamId(IN teamId INT)
BEGIN
    SELECT p.name, p.birthday, p.nationality, p.position, p.number
    FROM players p
    INNER JOIN team_player tp ON p.id = tp.player_id
    WHERE tp.team_id = teamId;
END//

DELIMITER ;
CALL GetPlayersByTeamId(2);


-- procedure with IN, OUT
-- This procedure provides full information about goals based on given player
DELIMITER //

CREATE PROCEDURE GetPlayerGoals(
    IN playerName VARCHAR(50),
    OUT totalGoals INT
)
BEGIN
    SELECT COUNT(*) INTO totalGoals
    FROM goals g
    JOIN players p ON g.player = p.id
    WHERE p.name = playerName;
END //

DELIMITER ;
CALL GetPlayerGoals('Virgil van Dijk', @totalGoals);
SELECT @totalGoals;

-- procedure with INOUT 
-- This procedure updates player's number
DELIMITER //
CREATE PROCEDURE UpdatePlayerNumber(
    INOUT player_id INT,
    IN new_number INT
)
BEGIN
    UPDATE players
    SET number = new_number
    WHERE id = player_id;
END//
DELIMITER ;

SET @player_id = 43;
CALL UpdatePlayerNumber(@player_id, 15);


-- procedure with transaction
-- It's update manager's name if team didn't score a goal, otherwise changes are cancelled 
DELIMITER //

CREATE PROCEDURE UpdateTeamManager(IN team_id INT, IN new_manager_name VARCHAR(255))
BEGIN
    DECLARE total_goals INT;

    START TRANSACTION;

    UPDATE teams SET manager_name = new_manager_name WHERE id = team_id;

    SELECT SUM(goals_for) INTO total_goals
    FROM standings
    WHERE team_id = team_id;

    IF total_goals > 0 THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END//

DELIMITER ;

CALL UpdateTeamManager(1, 'New manager');
SELECT * FROM teams;

-- procedure with transaction
-- It's update player's position to 'Substitute' if player's age > 38
DELIMITER //

CREATE PROCEDURE UpdatePlayerPosition()
BEGIN
    START TRANSACTION;

    UPDATE players
    SET position = 'Substitute'
    WHERE NOT EXISTS (
        SELECT *
        FROM (SELECT * FROM players) AS p
        WHERE YEAR(CURRENT_DATE()) - YEAR(p.birthday) < 38
    );

    COMMIT;
END//

DELIMITER ;

CALL UpdatePlayerPosition();

SELECT * FROM players;


