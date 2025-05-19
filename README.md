# QUESTION STRATEGIES

# 1. High-Value Customers with Multiple Products

I needed to:

1. Identify users with at least one savings plan.

2. Identify users with at least one investment plan.

3. Intersect those user IDs.

4. Get total deposits per user for ordering.


# 2. Transaction Frequency Analysis

I needed to:

1. Count transactions, and group by user and month.
2. Compute the average number of transactions per month for each customer.
3. Categorize each customer based on the defined frequency bands.
4. Aggregate the number of customers per frequency band and the average transactions per category.


# 3. Account Inactivity Alert

1. A plan is considered inactive if it hasn’t had any inflow in the last 365 days.
2. Inflow transactions = successful transactions (transaction_status = 'success')


# 4. Customer Lifetime Value (CLV) Estimation
