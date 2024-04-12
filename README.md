MySQL Football League System Database

This project focuses on managing a database schema for a football league system, including players, leagues, and other related entities. The project utilizes various queries, many-to-many relationships, subqueries, transactions, indexes, and views.

Schema Overview
The database schema consists of several tables representing different entities within the football league system. Here's a brief overview of the main tables:
1. teams: Information about football teams: name, city, stadium, manager name. Primary key is ID.
2. players: Information about players: name, birthday, nationality, position, number. Primary key is ID.
3. team_player: Represents the many-to-many relationship between players and teams. Primary key is player's ID and team's ID. Foreign key team_id referencing the ID column in teams table. Foreign key player_id referencing the ID column in players table.
4. seasons: Information about seasons: name. Primary key is ID.
5. leagues: Information about leagues: name, team_numbers. Primary key is ID.
6. match_day: Manage match days within a specific season and league: season_id, league_id, day_number. Primary key is ID. Foreign key season_id referencing the id column in the seasons table. Foreign key league_id referencing the id column in the leagues table. Constraint unique_season_league_day ensures that each combination of season, league, and day number is unique.
7. matches: Information about matches: name, game date, venue, home team, away team, home score, away score, match day. Primary key is ID. Foreign key home_id referencing the id column in the teams table, indicating the home team. Foreign key away_id referencing the id column in the teams table, indicating the away team. Foreign key match_day referencing the id column in the match_day table, specifying the match day associated with the match.
8. goals: Information about goals: game, player, team, goal time. Primary key is ID. Foreign key game referencing the id column in the matches table, indicating the match in which the goal was scored. Foreign key player referencing the id column in the players table, specifying the player who scored the goal. Foreign key team referencing the id column in the teams table, indicating the team that scored the goal.
9. standings: Information about standings: points, played, won, drawn, lost, goals for, goals against, match day. Primary Key combined primary on id and match_day to ensure uniqueness. Foreign key id referencing the id column in the teams table, identifying the team for which the standings are recorded. Foreign key match_day referencing the id column in the match_day table, indicating the match day for which the standings are recorded.
