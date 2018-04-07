-- 1.2.2
--
-- The ID's and durations for all trips of duration greater than 500, ordered by duration
SELECT
	trip_id, duration
FROM
	trips
WHERE
	duration > 500
ORDER BY duration

-- Every column of the stations table for station id 84
SELECT
*
FROM
	stations
WHERE
	station_id == 84

-- The min temperatures of all the occurrences of rain in zip 94301
-- NOTE: this returns no rows; there are no days recorded with preciptation in 94301
-- QUESTION: if you delete the ZIP condition, you'll see some PrecipitationIn values
-- that are listed as 'T'.  What does this mean - and how could I figure that out?
SELECT
	MinTemperatureF, PrecipitationIn, ZIP
FROM
	weather
WHERE
	PrecipitationIn > 0 AND
	ZIP == 94301
ORDER BY PrecipitationIn


-- 1.2.3
--
-- What was the hottest day in our data set? Where was that?
-- A: 134 F, in ZIP code 94063  (error in the data?)
SELECT
	ZIP,
	MAX(MaxTemperatureF)
FROM
	weather
GROUP BY ZIP

-- How many trips started at each station?
SELECT
	start_station,
	COUNT(*) trip_count
FROM
	trips
GROUP BY start_station
ORDER BY trip_count DESC

-- How many trips started at each station?
-- A: 60s
SELECT
	duration
FROM
	trips
ORDER BY duration

-- What is the average trip duration, by end station?
SELECT
	end_station,
	AVG(duration) avg_duration
FROM
	trips
GROUP BY end_station
ORDER BY avg_duration
