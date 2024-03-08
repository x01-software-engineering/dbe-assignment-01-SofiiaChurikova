create database football_league;
use football_league;
CREATE TABLE teams(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    stadium VARCHAR(30) NOT NULL,
    manager_name VARCHAR(20) NOT NULL
);
CREATE TABLE players(
    id INT AUTO_INCREMENT PRIMARY KEY,
    team INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    birthday DATE NOT NULL,
    nationality VARCHAR(20) NOT NULL,
    position VARCHAR(20) NOT NULL,
    number INT NOT NULL,
    FOREIGN KEY (team) REFERENCES teams(id)
);
CREATE TABLE team_player (
    team_id INT,
    player_id INT,
    PRIMARY KEY (team_id, player_id),
    FOREIGN KEY (team_id) REFERENCES teams(id),
    FOREIGN KEY (player_id) REFERENCES players(id)
);
CREATE TABLE seasons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name varchar(50) NOT NULL
);
CREATE TABLE leagues (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    team_numbers INT NOT NULL
);
CREATE TABLE match_day (
    id INT AUTO_INCREMENT PRIMARY KEY,
    season_id INT NOT NULL,
    league_id INT NOT NULL,
    day_number INT NOT NULL CHECK (day_number > 0),
    CONSTRAINT unique_season_league_day UNIQUE(season_id, league_id, day_number),
    FOREIGN KEY (season_id) REFERENCES seasons(id),
    FOREIGN KEY (league_id) REFERENCES leagues(id)
);
CREATE TABLE matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(90) NOT NULL,
    game_date DATETIME NOT NULL,
    venue VARCHAR(50),
    home_id INT NOT NULL,
    away_id INT NOT NULL,
    home_score INT NOT NULL,
    away_score INT NOT NULL,
    match_day INT NOT NULL,
    FOREIGN KEY (home_id) REFERENCES teams(id),
    FOREIGN KEY (away_id) REFERENCES teams(id),
    FOREIGN KEY (match_day) REFERENCES match_day(id)
);
CREATE TABLE goals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    game INT NOT NULL,
    player INT NOT NULL,
    team INT NOT NULL,
    goal_time TIME NOT NULL,
    FOREIGN KEY (game) REFERENCES matches(id),
    FOREIGN KEY (player) REFERENCES players(id),
    FOREIGN KEY (team) REFERENCES teams(id)
);
CREATE TABLE standings (
    id INT NOT NULL,
    points INT NOT NULL,
    played INT NOT NULL,
    won INT NOT NULL,
    drawn INT NOT NULL,
    lost INT NOT NULL,
    goals_for INT NOT NULL,
    goals_against INT NOT NULL,
    match_day INT NOT NULL,
    PRIMARY KEY (id, match_day),
    FOREIGN KEY (id) REFERENCES teams(id),
    FOREIGN KEY (match_day) REFERENCES match_day(id)
);
INSERT INTO teams(name, city, stadium, manager_name) VALUES
('Liverpool','Liverpool', 'Anfield', 'Jürgen Klopp'),
('Manchester City', 'Manchester', 'Etihad Stadium', 'Pep Guardiola'),
('Arsenal', 'London', 'Emirates Stadium', 'Mikel Arteta'),
('Tottenham Hotspur', 'London', 'Tottenham Hotspur Stadium', 'Nuno Espirito Santo'),
('Aston Villa', 'Birmingham', 'Villa Park', 'Steven Gerrard'),
('Bournemouth', 'Bournemouth', 'Vitality Stadium', 'Eddie Howe');

INSERT INTO players(team, name, birthday, nationality, position, number) VALUES
(1, 'Virgil van Dijk', '1991-07-08', 'Dutch', 'Defender', 4),
(1, 'Joe Gomez', '1997-05-23', 'English', 'Defender', 12),
(1, 'Alisson Becker', '1992-10-02', 'Brazilian', 'Goalkeeper', 1),
(1, 'Luis Diaz', '1997-01-13', 'Colombian', 'Forward', 23),
(1, 'Diogo Jota', '1996-12-04', 'Portuguese', 'Forward', 20),
(1, 'Ben Doak', '2004-04-07', 'Scottish', 'Midfielder', 50),
(1, 'Lewis Koumas', '2003-08-08', 'English', 'Midfielder', 38),
(1, 'Trey Nyoni', '2004-06-16', 'English', 'Forward', 54),
(1, 'Harvey Elliott', '2003-04-04', 'English', 'Midfielder', 67),
(1, 'Curtis Jones', '2001-01-30', 'English', 'Midfielder', 17),
(1, 'Bobby Clark', '2003-06-26', 'English', 'Forward', 59),
(1, 'Harry Maguire', '1993-03-05', 'English', 'Defender', 5),
(2, 'Bruno Fernandes', '1994-09-08', 'Portuguese', 'Midfielder', 18),
(2, 'Paul Pogba', '1993-03-15', 'French', 'Midfielder', 6),
(2, 'Jadon Sancho', '2000-03-25', 'English', 'Forward', 25),
(2, 'Marcus Rashford', '1997-10-31', 'English', 'Forward', 10),
(2, 'Aaron Wan-Bissaka', '1997-11-26', 'English', 'Defender', 29),
(2, 'David de Gea', '1990-11-07', 'Spanish', 'Goalkeeper', 1),
(2, 'Scott McTominay', '1996-12-08', 'Scottish', 'Midfielder', 39),
(2, 'Luke Shaw', '1995-07-12', 'English', 'Defender', 23),
(2, 'Rico Lewis', '2002-02-15', 'English', 'Midfielder', 42),
(2, 'John Stones', '1994-05-28', 'English', 'Defender', 5),
(2, 'Pierre-Emerick Aubameyang', '1989-06-18', 'Gabonese', 'Forward', 14),
(2, 'Bukayo Saka', '2001-09-05', 'English', 'Midfielder', 7),
(3, 'Thomas Partey', '1993-06-13', 'Ghanaian', 'Midfielder', 18),
(3, 'Emile Smith Rowe', '2000-07-28', 'English', 'Midfielder', 10),
(3, 'Ben White', '1997-10-08', 'English', 'Defender', 4),
(3, 'Aaron Ramsdale', '1998-05-14', 'English', 'Goalkeeper', 32),
(3, 'Kieran Tierney', '1997-06-05', 'Scottish', 'Defender', 3),
(3, 'Alexandre Lacazette', '1991-05-28', 'French', 'Forward', 9),
(3, 'Granit Xhaka', '1992-09-27', 'Swiss', 'Midfielder', 34),
(3, 'Gabriel Magalhães', '1997-12-19', 'Brazilian', 'Defender', 6),
(3, 'Kai Havertz', '1999-06-11', 'German', 'Midfielder', 29),
(3, 'Harry Kane', '1993-07-28', 'English', 'Forward', 10),
(3, 'Son Heung-Min', '1992-07-08', 'South Korean', 'Forward', 7),
(3, 'Hugo Lloris', '1986-12-26', 'French', 'Goalkeeper', 1),
(4, 'Tanguy Ndombele', '1996-12-28', 'French', 'Midfielder', 28),
(4, 'Sergio Reguilón', '1996-12-16', 'Spanish', 'Defender', 3),
(4, 'Eric Dier', '1994-01-15', 'English', 'Defender', 15),
(4, 'Pierre-Emile Højbjerg', '1995-08-05', 'Danish', 'Midfielder', 5),
(4, 'Davinson Sánchez', '1996-06-12', 'Colombian', 'Defender', 6),
(4, 'Steven Bergwijn', '1997-10-08', 'Dutch', 'Forward', 23),
(4, 'Matt Doherty', '1991-01-16', 'Irish', 'Defender', 2),
(4, 'Dele Alli', '1996-04-11', 'English', 'Midfielder', 20),
(4, 'Emiliano Martínez', '1992-09-02', 'Argentinian', 'Goalkeeper', 26),
(4, 'Ollie Watkins', '1995-12-30', 'English', 'Forward', 11),
(4, 'John McGinn', '1994-10-18', 'Scottish', 'Midfielder', 7),
(4, 'Tyrone Mings', '1993-03-13', 'English', 'Defender', 5),
(5, 'Matt Targett', '1995-09-18', 'English', 'Defender', 3),
(5, 'Bertrand Traoré', '1995-09-06', 'Burkinabé', 'Forward', 15),
(5, 'Douglas Luiz', '1998-05-09', 'Brazilian', 'Midfielder', 6),
(5, 'Ezri Konsa', '1998-10-23', 'English', 'Defender', 4),
(5, 'Anwar El Ghazi', '1995-05-03', 'Dutch', 'Forward', 21),
(5, 'Ashley Young', '1985-07-09', 'English', 'Midfielder', 18),
(5, 'Jacob Ramsey', '2002-05-28', 'English', 'Midfielder', 41),
(5, 'Asmir Begović', '1987-06-20', 'Bosnian', 'Goalkeeper', 27),
(5, 'Adam Smith', '1991-04-29', 'English', 'Defender', 15),
(5, 'Steve Cook', '1991-04-19', 'English', 'Defender', 3),
(5, 'Nathan Aké', '1995-02-18', 'Dutch', 'Defender', 5),
(5, 'Diego Rico', '1993-02-23', 'Spanish', 'Defender', 55),
(6, 'Callum Wilson', '1992-02-27', 'English', 'Forward', 13),
(6, 'Dominic Solanke', '1997-09-14', 'English', 'Forward', 9),
(6, 'Philip Billing', '1996-06-11', 'Danish', 'Midfielder', 8),
(6, 'Jefferson Lerma', '1994-10-25', 'Colombian', 'Midfielder', 8),
(6, 'Lloyd Kelly', '1998-10-22', 'English', 'Defender', 26),
(6, 'David Brooks', '1997-07-08', 'Welsh', 'Midfielder', 7),
(6, 'Chris Mepham', '1997-11-05', 'Welsh', 'Defender', 5),
(6, 'Arnaut Danjuma', '1997-08-31', 'Dutch', 'Forward', 10),
(6, 'Emiliano Marcondes', '1995-03-17', 'Danish', 'Midfielder', 22),
(6, 'Gavin Kilkenny', '1999-11-08', 'Irish', 'Midfielder', 42),
(6, 'Zeno Ibsen Rossi', '2001-05-10', 'Norwegian', 'Midfielder', 36),
(6, 'Jordan Zemura', '2000-11-14', 'Zimbabwean', 'Defender', 17);

INSERT INTO team_player (team_id, player_id) VALUES
(1, 1), 
(1, 2), 
(1, 3), 
(1, 4), 
(1, 5), 
(1, 6), 
(1, 7), 
(1, 8), 
(1, 9), 
(1, 10), 
(1, 11),
(1, 12), 
(2, 13), 
(2, 14), 
(2, 15), 
(2, 16), 
(2, 17), 
(2, 18), 
(2, 19), 
(2, 20), 
(2, 21), 
(2, 22),
(2, 23), 
(2, 24), 
(3, 25), 
(3, 26), 
(3, 27), 
(3, 28), 
(3, 29), 
(3, 30), 
(3, 31), 
(3, 32),
(3, 33), 
(3, 34), 
(3, 35), 
(3, 36), 
(4, 37), 
(4, 38), 
(4, 39), 
(4, 40), 
(4, 41), 
(4, 42),
(4, 43), 
(4, 44), 
(4, 45), 
(4, 46), 
(4, 47), 
(4, 48), 
(5, 49), 
(5, 50), 
(5, 51), 
(5, 52),
(5, 53), 
(5, 54), 
(5, 55), 
(5, 56), 
(5, 57), 
(5, 58), 
(5, 59), 
(5, 60),
(6, 61), 
(6, 62), 
(6, 63), 
(6, 64),
(6, 65), 
(6, 66), 
(6, 67), 
(6, 68), 
(6, 69), 
(6, 70), 
(6, 71), 
(6, 72);

INSERT INTO seasons (name) VALUES
('2023-2024'),
('2024-2025'),
('2025-2026'),
('2026-2027'),
('2027-2028');

INSERT INTO leagues (name, team_numbers) VALUES
('English Premier League', 6),
('La Liga', 6),
('Bundesliga', 6),
('Serie A', 6),
('Ligue 1', 6);

INSERT INTO match_day (season_id, league_id, day_number)
VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 2, 3),
(1, 3, 4),
(1, 4, 5),
(1, 5, 6);

INSERT INTO matches(name, game_date, venue, home_id, away_id, home_score, away_score, match_day)
VALUES
('Premier League Match 1', '2024-02-20 15:30:00', 'Anfield', 1, 2, 3, 2, 1),
('Premier League Match 2', '2024-02-21 18:00:00', 'Etihad Stadium', 2, 3, 2, 0, 1),
('Premier League Match 3', '2024-02-22 20:15:00', 'Emirates Stadium', 3, 4, 1, 1, 1),
('Premier League Match 4', '2024-02-23 17:30:00', 'Tottenham Hotspur Stadium', 4, 5, 3, 1, 2),
('Premier League Match 5', '2024-02-24 19:45:00', 'Villa Park', 5, 1, 0, 2, 2),
('Premier League Match 6', '2024-02-25 16:00:00', 'Anfield', 1, 3, 4, 2, 2),
('Premier League Match 7', '2024-02-26 14:30:00', 'Etihad Stadium', 2, 4, 1, 0, 3),
('Premier League Match 8', '2024-02-27 16:45:00', 'Tottenham Hotspur Stadium', 4, 1, 2, 2, 4),
('Premier League Match 9', '2024-02-28 19:00:00', 'Emirates Stadium', 3, 5, 2, 1, 4),
('Premier League Match 10', '2024-02-29 20:30:00', 'Villa Park', 5, 2, 1, 3, 5),
('Premier League Match 11', '2024-03-01 14:00:00', 'Vitality Stadium', 6, 1, 5, 1, 6),
('Premier League Match 12', '2024-03-02 16:30:00', 'Vitality Stadium', 6, 2, 2, 3, 6);


INSERT INTO goals(game, player, team, goal_time) VALUES
(1, 1, 1, '00:15:00'),
(1, 4, 1, '00:30:00'),
(2, 11, 2, '00:10:00'),
(2, 14, 2, '00:32:00'),
(3, 16, 3, '00:42:00'),
(3, 22, 4, '00:55:00'), 
(4, 23, 4, '00:20:00'), 
(4, 29, 5, '00:29:00'),
(5, 2, 1, '00:25:00'),
(5, 9, 1, '00:35:00'),
(6, 49, 5, '00:10:00'),
(6, 50, 6, '00:06:00');

INSERT INTO standings(id, points, played, won, drawn, lost, goals_for, goals_against, match_day) VALUES
(1, 9, 3, 3, 0, 0, 10, 3, 1),
(2, 6, 3, 2, 0, 1, 6, 4, 1),
(3, 4, 3, 1, 1, 1, 4, 4, 2),
(4, 4, 3, 1, 1, 1, 5, 5, 2),
(5, 1, 3, 0, 1, 2, 1, 1, 3),
(6, 1, 3, 0, 2, 0, 1, 3, 3),
(1, 9, 3, 3, 0, 0, 10, 3, 4),
(2, 6, 3, 2, 0, 1, 6, 4, 4),
(3, 4, 3, 1, 1, 1, 4, 4, 4),
(4, 4, 3, 1, 1, 1, 5, 5, 4),
(5, 1, 3, 0, 1, 2, 1, 7, 5),
(6, 1, 3, 0, 2, 0, 1, 8, 5),
(1, 9, 3, 3, 0, 0, 10, 3, 5),
(2, 6, 3, 2, 0, 1, 6, 4, 5),
(3, 4, 3, 1, 1, 1, 4, 4, 6),
(4, 4, 3, 1, 1, 1, 5, 5, 6),
(5, 1, 3, 0, 1, 2, 1, 7, 6),
(6, 1, 3, 0, 2, 0, 1, 8, 6);

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
