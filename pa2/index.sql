CREATE TABLE clone_players LIKE players;
INSERT INTO clone_players SELECT * FROM players;
CREATE INDEX idx_nationality ON clone_players (nationality);

SELECT * FROM players
WHERE nationality = "Colombian";

SELECT * FROM clone_players
WHERE nationality = "Colombian";
