WITH saving_customers AS (
SELECT s.owner_id, COUNT(s.savings_id) AS savings_count, SUM(s.confirmed_amount) AS savings_deposits
FROM savings_savingsaccount AS s
INNER JOIN plans_plan AS p
    ON s.plan_id = p.id
WHERE s.transaction_status = 'success'
	AND p.is_regular_savings = 1
GROUP BY s.owner_id)
,
investing_customers AS (
SELECT s.owner_id, COUNT(s.savings_id) AS investment_count, SUM(s.confirmed_amount) AS investment_deposits
FROM savings_savingsaccount AS s
INNER JOIN plans_plan AS p
    ON s.plan_id = p.id
WHERE s.transaction_status = 'success'
	AND p.is_a_fund = 1
GROUP BY s.owner_id)
,
cross_customers AS (
SELECT s.owner_id, s.savings_count, i.investment_count, s.savings_deposits, i.investment_deposits
FROM saving_customers AS s
INNER JOIN investing_customers AS i
	ON s.owner_id = i.owner_id)
    

SELECT u.id AS owner_id, 
	CONCAT(u.first_name, ' ', u.last_name) AS name,
    c.savings_count,
    c.investment_count,
    ROUND(((c.savings_deposits + c.investment_deposits) / 100), 2) AS total_deposits
FROM users_customuser AS u
INNER JOIN cross_customers AS c
	ON u.id = c.owner_id
