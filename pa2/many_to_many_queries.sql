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
