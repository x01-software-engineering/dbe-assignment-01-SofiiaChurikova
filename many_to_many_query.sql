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
