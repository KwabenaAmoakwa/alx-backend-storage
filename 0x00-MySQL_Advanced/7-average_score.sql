-- Write a SQL script that creates a stored procedure ComputeAverageScoreForUser
DELIMITER $$

CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
   
    DECLARE avg_score DECIMAL(10, 2);

    -- Start transaction
    START TRANSACTION;

    -- Calculate the average score
    SELECT AVG(score) INTO avg_score FROM scores WHERE user_id = user_id;

    -- Check if avg_score is not NULL
    IF avg_score IS NOT NULL THEN
        -- Update the user's record with the computed average score
        UPDATE users SET average_score = avg_score WHERE id = user_id;
        -- Commit the transaction
        COMMIT;
    ELSE
        -- Rollback if no scores were found
        ROLLBACK;
    END IF;

END$$

DELIMITER ;
