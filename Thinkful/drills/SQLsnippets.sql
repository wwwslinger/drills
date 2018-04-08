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

-- 1.2.4

-- 1. What are the three longest trips on rainy days?
SELECT
	trips.trip_id,
	weather.Date,
	trips.duration
FROM trips
JOIN weather
ON
	weather.Date == DATE(trips.start_date) AND
	weather.ZIP == trips.zip_code
WHERE weather.Events == 'Rain'
ORDER BY trips.duration DESC


-- 2. Which station is full most often?
-- NOTE: this doesn't work with the abbreviated status dataset - and the full set
-- is too slow for my machine
SELECT
	station_id,
	docks_available,
	timestamp,
	COUNT(*) minutes_full
FROM status_abbreviated
WHERE docks_available == 0
GROUP BY station_id
ORDER BY minutes_full DESC

-- 3. Return a list of stations with a count of number of trips starting at
--    that station but ordered by dock count.
WITH departure_counts
AS (
	SELECT
		start_station,
		COUNT(*) departures
	FROM trips
	GROUP BY start_station
)

SELECT
	stations.dockcount,
	stations.name,
	departure_counts.departures
FROM stations
JOIN departure_counts
ON stations.name == departure_counts.start_station
ORDER BY stations.dockcount


-- 4.(Challenge) What's the length of the longest trip for each day it rains anywhere?

-- first, must make a table with only one rain status per date
WITH rainy_days
AS (
	SELECT Date
	FROM weather
	WHERE Events == 'Rain'
	GROUP BY Date
)
-- then merge with trips table and sort by duration
SELECT
	trips.trip_id,
	rainy_days.Date,
	trips.duration
FROM trips
JOIN rainy_days
ON rainy_days.Date == DATE(trips.start_date)
ORDER BY trips.duration DESC
