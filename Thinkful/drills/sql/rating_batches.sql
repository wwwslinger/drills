WITH batch_counts AS (
	SELECT
    user_id,
    day,
	COUNT(*) as review_count
	FROM joined_short
    GROUP BY user_id, day

SELECT *
FROM joined_short
WHERE review_count <= 2
LEFT JOIN batch_counts ON joined_short.user_id = batch_counts.user_id AND joined_short.day = batch_counts.day