WITH monthly_transactions_per_user AS (
SELECT s.owner_id, MONTH(s.created_on) AS transaction_month, COUNT(s.savings_id) AS monthly_transaction_count
FROM savings_savingsaccount AS s
GROUP BY 1, 2)
,
average_transactions_per_user AS (
SELECT m.owner_id, AVG(m.monthly_transaction_count) AS average_number_of_transactions
FROM monthly_transactions_per_user AS m
GROUP BY owner_id)
,
user_categories AS (
SELECT a.owner_id, a.average_number_of_transactions, CASE WHEN a.average_number_of_transactions >= 10 THEN 'High Frequency'
															WHEN a.average_number_of_transactions >= 3 THEN 'Medium Frequency'
															ELSE 'Low Frequency'
													END AS frequency_category
FROM average_transactions_per_user AS a)

SELECT u.frequency_category, 
		COUNT(u.owner_id) AS customer_count,
        ROUND(AVG(u.average_number_of_transactions), 1) AS avg_transactions_per_month
FROM user_categories AS u
GROUP BY u.frequency_category



