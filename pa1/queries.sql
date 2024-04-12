SELECT teams.name AS team, ROUND(AVG(YEAR(CURRENT_DATE) - YEAR((players.birthday))), 1) AS avg_age
FROM players
JOIN teams ON players.team = teams.id
JOIN goals ON players.id = goals.player
WHERE YEAR(CURRENT_DATE) - YEAR(players.birthday) < 29
GROUP BY teams.name;

SELECT players.name AS player, teams.name AS team, matches.id AS match_name, goals.goal_time AS goal
FROM players
JOIN goals ON players.id = goals.player
JOIN teams ON goals.team = teams.id
JOIN matches ON goals.game = matches.id
ORDER BY goal;

SELECT name, birthday, number
FROM players
WHERE number > 4
ORDER BY name DESC
LIMIT 15;

SELECT teams.name, SUM(standings.goals_for) AS total_goals, SUM(standings.goals_against) AS miss_goals, SUM(standings.goals_for) - SUM(standings.goals_against) AS goals_difference
FROM teams
JOIN standings ON teams.id = standings.id
GROUP BY teams.name
HAVING total_goals > 1
ORDER BY total_goals DESC;

SELECT teams.name, teams.city, teams.manager_name, SUM(standings.won) AS win
FROM teams
JOIN standings ON teams.id = standings.id
GROUP BY teams.name, teams.city, teams.manager_name
ORDER BY win DESC;
