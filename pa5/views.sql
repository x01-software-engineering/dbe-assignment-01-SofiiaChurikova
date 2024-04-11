-- Create a view that stores info about the player, team, the num of scored goals, days and time of scored goals
CREATE VIEW best_strikers AS
SELECT p.name AS player_name, t.name AS team_name, COUNT(1) AS total_goals, 
GROUP_CONCAT(CONCAT(md.day_number, '(', g.goal_time, ')')) AS match_days_with_goals
FROM goals g
INNER JOIN players p ON g.player = p.id
INNER JOIN teams t ON g.team = t.id
INNER JOIN match_day md ON g.game IN (SELECT id FROM matches WHERE match_day = md.day_number)
GROUP BY p.id, t.id
ORDER BY player_name, team_name;

select * from best_strikers;

-- Create indexes to optimize search by view
CREATE INDEX idx_goals_player_team ON goals(player, team);
CREATE INDEX idx_matches_match_day ON matches(match_day);
CREATE INDEX idx_match_day_day_number ON match_day(day_number);
CREATE INDEX idx_players_id ON players(id);
CREATE INDEX idx_teams_id ON teams(id);
