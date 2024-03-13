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
