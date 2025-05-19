WITH last_inflow_dates AS (
SELECT s.plan_id, MAX(s.created_on) AS last_transaction_date
FROM savings_savingsaccount AS s
WHERE s.transaction_status = 'success'
GROUP BY s.plan_id)
,
plans AS (
SELECT p.id, p.owner_id, CASE WHEN p.is_regular_savings = 1 THEN 'Savings'
								WHEN p.is_a_fund = 1 THEN 'Investment'
						END AS type
FROM plans_plan AS p
WHERE p.is_regular_savings = 1 
	OR p.is_a_fund = 1)
 ,   
final AS (
SELECT p.id AS plan_id, p.owner_id, p.type, l.last_transaction_date, DATEDIFF(CURRENT_DATE, l.last_transaction_date) AS inactivity_days
FROM plans AS p
INNER JOIN last_inflow_dates AS l
	ON p.id = l.plan_id)
    
    
SELECT *
FROM final
WHERE inactivity_days > 365
ORDER BY inactivity_days DESC
