WITH customer_transactions AS (
SELECT s.owner_id, COUNT(savings_id) AS transaction_count, ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_transaction_value_in_naira, 
	((SUM(s.confirmed_amount) / 100) * 0.001) / COUNT(savings_id) AS average_profit_per_transaction
FROM savings_savingsaccount AS s
WHERE s.transaction_status = 'success'
GROUP BY s.owner_id)
,
user_tenures AS (
SELECT u.id, CONCAT(u.first_name, ' ', u.last_name) AS name, TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months
FROM users_customuser AS u
WHERE u.is_active = 1)

SELECT u.id AS customer_id, u.name, u.tenure_months, c.transaction_count AS total_transactions,
		((c.transaction_count / u.tenure_months) * 12 * c.average_profit_per_transaction) AS estimated_clv
FROM user_tenures AS u
INNER JOIN customer_transactions AS c
	ON u.id = c.owner_id
ORDER BY estimated_clv DESC