-- procedure with IN
-- This procedure provides full information based on given team ID
DELIMITER //

CREATE PROCEDURE get_players_by_team_id_sproc(IN id_team INT)
BEGIN
    SELECT p.name, p.birthday, p.nationality, p.position, p.number
    FROM players p
    INNER JOIN team_player tp ON p.id = tp.player_id
    WHERE tp.team_id = id_team;
END//

DELIMITER ;


-- procedure with IN, OUT
-- This procedure provides full information about goals based on given player
DELIMITER //

CREATE PROCEDURE get_player_goals_sproc(
    IN player_name VARCHAR(50),
    OUT total_goals INT
)
BEGIN
    SELECT COUNT(*) INTO total_goals
    FROM goals g
    JOIN players p ON g.player = p.id
    WHERE p.name = player_name;
END //

DELIMITER ;


-- procedure with INOUT 
-- This procedure updates player's number
DELIMITER //
CREATE PROCEDURE update_player_number_sproc(
    INOUT player_id INT,
    IN new_number INT
)
BEGIN
    UPDATE players
    SET number = new_number
    WHERE id = player_id;
END//
DELIMITER ;


-- procedure with transaction
-- It's update manager's name if team didn't score a goal, otherwise changes are cancelled 
DELIMITER //

CREATE PROCEDURE update_team_manager_sproc(IN team_id INT, IN new_manager_name VARCHAR(255))
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


-- procedure with transaction
-- It's update player's position to 'Substitute' if player's age > 38
DELIMITER //

CREATE PROCEDURE update_player_position_sproc()
BEGIN
    START TRANSACTION;

    UPDATE players
    SET position = 'Substitute'
    WHERE id IN (
    SELECT id
    FROM (
        SELECT *, YEAR(CURRENT_DATE()) - YEAR(birthday) AS age 
        FROM players
    ) AS p
    WHERE p.age > 36
);

    COMMIT;
END//

DELIMITER ;



