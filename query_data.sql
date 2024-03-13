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

SELECT players.name AS name, teams.name AS team, COUNT(goals.id) AS goals
FROM players
JOIN team_player ON players.id = team_player.player_id
JOIN teams ON team_player.team_id = teams.id
LEFT JOIN goals ON players.id = goals.player
GROUP BY players.id, teams.id
ORDER BY team;

SELECT teams.name AS team_name, players.name AS player_name
FROM teams
JOIN team_player ON teams.id = team_player.team_id
JOIN players ON team_player.player_id = players.id
JOIN matches ON teams.id = matches.home_id OR teams.id = matches.away_id
WHERE matches.id = 2;

SELECT players.name AS name, teams.name AS team, matches.name AS match_name, seasons.name AS season, leagues.name AS league, COUNT(goals.id) AS total_goals
FROM players
JOIN goals ON players.id = goals.player
JOIN matches ON goals.game = matches.id
JOIN teams ON goals.team = teams.id
JOIN match_day ON matches.match_day = match_day.id
JOIN seasons ON match_day.season_id = seasons.id
JOIN leagues ON match_day.league_id = leagues.id
WHERE players.name = 'Virgil van Dijk'
GROUP BY players.name, teams.name, matches.name, seasons.name, leagues.name;
