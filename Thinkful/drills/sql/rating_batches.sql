ALTER TABLE movieLens.ratings_short 
ADD COLUMN month1 INT AFTER timestamp;
UPDATE movieLens.ratings_short SET month1 = timestamp;
/*
MONTH(
	CONVERT(
		DATE_ADD(
			'1970-01-01 00:00:00', INTERVAL movieLens.ratings_short.timestamp SECOND
				), datetime
			)
		)
*/