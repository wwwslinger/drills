SELECT
	user_id,
	movieLens.ratings_short.movie_id,
	title,
	genre,
	timestamp,
	CONVERT(DATE_ADD('1970-01-01 00:00:00', INTERVAL movieLens.ratings_short.timestamp SECOND), datetime) AS date_time
FROM movieLens.ratings_short
INNER JOIN movieLens.movies_short ON movieLens.ratings_short.movie_id = movieLens.movies_short.movie_id
LIMIT 10