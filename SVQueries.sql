-- Itinerary 113 24 hour Not-Checked In List
SELECT p.First_name, p.Last_name, t.Passenger_ID
FROM Ticket t
JOIN Passenger p
ON p.Passenger_ID = t.Passenger_ID 
WHERE t.Status = 'Not Checked-In' AND
	t.Itinerary_ID = 113
ORDER BY p.First_name ASC;


-- Age calculation & segmentation
SELECT ROUND(DATEDIFF(CURDATE(), DOB) / 365) AS 'Age (yrs)',
    CASE 
        WHEN ROUND(DATEDIFF(CURDATE(), DOB) / 365) < 18 THEN 'Child/Teen'
        WHEN ROUND(DATEDIFF(CURDATE(), DOB) / 365) BETWEEN 18 AND 30 THEN 'Young Adult'
        WHEN ROUND(DATEDIFF(CURDATE(), DOB) / 365) BETWEEN 31 AND 50 THEN 'Middle-Age'
        ELSE 'Senior'
    END AS "Age Group",
    COUNT(*) AS 'Count'
FROM Passenger
GROUP BY ROUND(DATEDIFF(CURDATE(), DOB) / 365), "Age Group"
UNION
SELECT 'Average' AS 'Age (yrs)', 
NULL AS "Age Group", -- Set to NULL for the average row
	ROUND(AVG(DATEDIFF(CURDATE(), DOB) / 365)) AS 'Count'
FROM Passenger;


-- Number of unreserved seat:
SELECT COUNT(DISTINCT ss.Seat_Location) AS 'Unreserved Seat Count', t.Itinerary_ID
FROM Seat_Status ss
JOIN Ticket t ON ss.Seat_A_ID = t.Seat_A_ID
WHERE 
    ss.Status = 'Not Taken' AND 
    EXISTS (
        SELECT 1
        FROM Ticket t2
        WHERE ss.Seat_A_ID = t2.Seat_A_ID AND t2.Status = 'Not Checked-In'
    )
GROUP BY t.Itinerary_ID;


-- Baggage Type
SELECT t.Itinerary_ID, b.Ticket_ID, b.Weight,
CASE WHEN Weight > 40 THEN 'Check'
	ELSE 'Carry-On'
    END AS "Baggage Type"
FROM Baggage b
JOIN Ticket t
ON b.Ticket_ID = t.Ticket_ID
GROUP BY t.Itinerary_ID, b.Ticket_ID, b.Weight;


-- Class & Ticket Status Distribution
SELECT 
    sa.Boarding_Rank,
    COUNT(CASE WHEN t.Status = 'Checked-In' THEN 1 END) AS Checked_In_Count,
    COUNT(CASE WHEN t.Status != 'Checked-In' THEN 1 END) AS Not_Checked_In_Count,
    COUNT(*) AS Total_Count,
    ROUND(COUNT(CASE WHEN t.Status = 'Checked-In' THEN 1 END) / COUNT(*) * 100, 2) AS Checked_In_Percentage
FROM Seat_Assignment sa
JOIN Ticket t ON sa.Seat_A_ID = t.Seat_A_ID
GROUP BY sa.Boarding_Rank;
