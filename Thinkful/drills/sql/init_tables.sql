# CREATE MOVIES TABLE:
# (after this I loaded file via import wizard after failed SQL attempt)
CREATE TABLE IF NOT EXISTS movieLens.movies (
	movie_id INT DEFAULT NULL,
	title VARCHAR(100) DEFAULT NULL,
	genre VARCHAR(100) DEFAULT NULL
);

# CREATE RATINGS TABLE:
CREATE TABLE IF NOT EXISTS movieLens.ratings (
	user_id INT DEFAULT NULL,
	movie_id INT DEFAULT NULL,
	rating FLOAT DEFAULT NULL,
	timestamp INT DEFAULT NULL
);

# FAILED data loads
# Error Code: 1290. The MySQL server is running with the '--secure-file-priv' option 
# so it cannot execute this statement
/*
LOAD DATA INFILE '/Users/garrettfiddler/gDrive/Workspace/Thinkful/capstone_1/ml-latest-small/movies.csv'
INTO TABLE movies
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/Users/garrettfiddler/gDrive/Workspace/Thinkful/capstone_1/ml-latest-small/ratings.csv'
INTO TABLE ratings
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
*/