-- SELECTS
-- non-correlated
-- обирає команду, в якій є гравець Thomas Partey
SELECT teams.name AS team_name FROM teams
WHERE teams.id = (SELECT team_player.team_id
FROM team_player
JOIN players ON team_player.player_id = players.id
WHERE players.name = 'Thomas Partey');

-- виводить усіх гравців, які забили гол на стадіоні Villa Park
SELECT name AS player_name FROM players
JOIN goals ON players.id = goals.player
WHERE goals.game IN (
SELECT id FROM matches
WHERE venue = 'Villa Park'
);
-- виводить тренерів, які не є тренерами Liverpool, Arsenal, Bournemouth
SELECT manager_name FROM teams
WHERE manager_name NOT IN(
SELECT manager_name FROM teams
WHERE name IN ('Liverpool', 'Arsenal', 'Bournemouth')
);
-- обирає всі команди, де вони грали домашній матч(були на своїй території)
SELECT * FROM teams t
WHERE EXISTS (SELECT 1 FROM matches m WHERE m.home_id = t.id);

-- обирає команди, де вони не були домашньою командою у лізі з айді 3
SELECT * FROM teams t
WHERE NOT EXISTS (SELECT 1 FROM matches m INNER JOIN match_day md ON m.match_day = md.id WHERE md.league_id = 3 AND m.home_id = t.id);

-- correlated
-- обирає команди, айді яких існує в підзапиті
SELECT id, name
FROM teams t
WHERE t.id IN (
    SELECT tp.team_id    FROM team_player tp
    WHERE tp.team_id = t.id);
-- обирає гравців, 
SELECT id, name
FROM teams t
WHERE id NOT IN (    
    SELECT team_id
    FROM team_player tp    
    WHERE tp.team_id = t.id
);
-- виводить команду, в якій забили 2 гола
SELECT name AS team_name FROM teams
WHERE (
SELECT COUNT(*) FROM goals
JOIN players ON goals.player = players.id
JOIN team_player ON players.id = team_player.player_id
WHERE team_player.team_id = teams.id
) = 2;

-- виводить команди, в яких є гравець(вці) яким менше за 23 роки
SELECT name AS team_name 
FROM teams
WHERE EXISTS(
SELECT 1 FROM team_player
JOIN players ON team_player.player_id = players.id
WHERE team_player.team_id = teams.id AND YEAR(CURRENT_DATE()) - YEAR(players.birthday) < 23);

-- виводить команди, в яких нема гравця Virgil van Dijk
SELECT name AS team_name FROM teams
WHERE NOT EXISTS(SELECT 1 FROM team_player
JOIN players ON team_player.player_id = players.id
WHERE team_player.team_id = teams.id AND players.name = 'Virgil van Dijk'
);
-- UPDATES
-- non-correlated 
-- змінює національність гравцю ім'я Joe Gomez
UPDATE players
SET nationality = 'Dutch'
WHERE id = (SELECT id FROM (SELECT id FROM players WHERE name = 'Joe Gomez') AS temp LIMIT 1);

-- змінює ім'я менеджера для команди Tottenham Hotspur
UPDATE teams
SET manager_name = 'Liam Reynolds'
WHERE id IN (
    SELECT temp.id
    FROM (SELECT id FROM teams WHERE name = 'Tottenham Hotspur') AS temp
);
-- змінює стадіон для команд, які не були хазяїнами в іграх
UPDATE teams
SET stadium = 'BC Place'
WHERE id NOT IN (SELECT DISTINCT home_id FROM matches);

-- змінює ім'я нового менеджера для команд у яких рахунок > 9
UPDATE teams
SET manager_name = 'John Doe'
WHERE EXISTS (
    SELECT 1
    FROM standings
    WHERE points > 9
);
-- змінює позицію на Substitute для гравців, яким менше за 38
UPDATE players
SET position = 'Substitute'
WHERE NOT EXISTS (
    SELECT *
    FROM (SELECT * FROM players) AS p
    WHERE YEAR(CURRENT_DATE()) - YEAR(p.birthday) < 38
);


-- correlated
-- оновлює національність для гравця з Ліверпулю, який забив гол і має національність Colombian
UPDATE players
SET nationality = 'Dutch'
WHERE id IN (
    SELECT p.id
    FROM (SELECT * FROM players) p
    JOIN goals g ON p.id = g.player
    JOIN teams t ON g.team = t.id
    WHERE p.nationality = 'Colombian'
    AND t.name = 'Liverpool'
);

-- змінює гравцю Joe Gomez національність на Dutch
UPDATE players AS p1
JOIN (
    SELECT id
    FROM players
    WHERE name = 'Joe Gomez'
    LIMIT 1
) AS p2 ON p1.id = p2.id
SET p1.nationality = 'Dutch';

-- змінює позицію гравців на Substitute для тих, хто були в 2 матчі
UPDATE players
SET position = 'Substitute'
WHERE id IN (
    SELECT tp.player_id
    FROM team_player tp
    INNER JOIN matches m ON tp.team_id = m.home_id OR tp.team_id = m.away_id
    WHERE m.id = 2
);

-- забирає 3 голи в команд, в яких гравці не забили в останній день
UPDATE standings s
SET s.points = s.points - 3
WHERE s.id NOT IN (
  SELECT team FROM goals
  WHERE match_day = (SELECT MAX(day_number) FROM match_day)
);

-- змінює позицію на Striker для гравців, які зробили мінімум 1 гол
UPDATE players
SET position = 'Striker'
WHERE EXISTS (SELECT 1 FROM goals WHERE goals.player = players.id); 

-- змінює поле на Neutral Ground, якщо нема записей про home або away команду 
UPDATE matches
SET venue = 'Neutral Ground'
WHERE NOT EXISTS (
  SELECT 1 FROM teams
  WHERE teams.id = matches.home_id
  OR teams.id = matches.away_id
);


-- DELETE 
-- non-correlated
-- видаляє гол, час якого був 00:18:00
DELETE FROM goals
WHERE id = (SELECT id FROM (SELECT id FROM goals WHERE goal_time = '00:18:00') AS temp LIMIT 1);

-- видаляє гравців чия національність French
DELETE FROM players
WHERE id IN (
    SELECT id
    FROM (
        SELECT id
        FROM players
        WHERE nationality = 'French'
    ) AS temp
);

-- видаляє голи які забиті раніше ніж 20хв гри
DELETE FROM goals
WHERE id NOT IN (
    SELECT id
    FROM (
        SELECT id
        FROM goals
        WHERE goal_time >= '00:20:00'
    ) AS temp
);

-- видаляє команду де кількість поінтів більша за 9
DELETE FROM teams
WHERE EXISTS (
    SELECT 1
    FROM standings
    WHERE points > 9
);

-- видаляє гравців які не забили гол
DELETE FROM players
WHERE NOT EXISTS (
    SELECT player
    FROM goals
);

-- correlated
-- видаляє команди в яких 30 гравців
DELETE FROM teams t
WHERE (SELECT COUNT(*) FROM team_player tp WHERE tp.team_id = t.id) = 30;

-- видаляє голи, які команда зробила як хазяїн(домашня гра)
DELETE FROM goals
WHERE game IN(SELECT id
    FROM matches
    WHERE home_id IN (
        SELECT home_id
        FROM matches
        WHERE id = goals.game
    ));

-- видаляє ліги, які не пов'язані з днями гри
DELETE FROM leagues l
WHERE l.id NOT IN 
(SELECT DISTINCT md.league_id FROM match_day md WHERE md.league_id = l.id);

-- видаляє команди, у яких поінтів менше ніж 5
DELETE FROM teams
WHERE EXISTS (
    SELECT 1
    FROM standings
    WHERE id = teams.id
    AND points < 5
);

-- видаляє дані, коли не існує однакових ідентефікаторів home_id і away_id команд
DELETE FROM matches
WHERE NOT EXISTS (SELECT 1 FROM teams WHERE id = matches.home_id AND id = matches.away_id);


-- UNION
-- обираються гравці які забивали гол та об'єднуються з тими, хто не забивав
SELECT p.name AS player_name, t.name AS team_name 
FROM players p
INNER JOIN team_player tp ON tp.player_id = p.id
INNER JOIN teams t ON t.id = tp.team_id
WHERE p.id IN (
    SELECT DISTINCT player    FROM goals
)UNION
SELECT p.name AS player_name, t.name AS team_name FROM players p
INNER JOIN team_player tp ON tp.player_id = p.id
INNER JOIN teams t ON t.id = tp.team_id
WHERE p.id NOT IN (    SELECT DISTINCT player
    FROM goals);
-- INTERSECT
-- обирає гравців, які в Ліверпулі і які забили гол
SELECT p.id AS player_id, p.name AS player_name, t.name AS team_name 
FROM players p
INNER JOIN team_player tp ON tp.player_id = p.id
INNER JOIN teams t ON t.id = tp.team_id
WHERE t.name = 'Liverpool'
INTERSECT
SELECT p.id AS player_id, p.name AS player_name, t.name AS team_name 
FROM players p
INNER JOIN goals g ON p.id = g.player
INNER JOIN teams t ON t.id = g.team;
-- UNION ALL
-- обираються позиції для кожнгого гравця(кільк записів = кільк гравців) 
SELECT p.position AS player_position FROM players p
UNION ALL
SELECT p.position AS player_position
FROM players p;
-- EXCEPT
-- обирає команду, яка не виграла жодного разу
SELECT id, name
FROM teams
EXCEPT
SELECT id, name
FROM teams
WHERE id IN (SELECT id FROM standings WHERE won > 0);
