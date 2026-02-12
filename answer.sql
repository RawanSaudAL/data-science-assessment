-- The goal of this query is to understand how each investors
-- portfolio is distributed across sectors in percentage terms.

-- Step 1:
-- Aggregate shares per investor per sector.
-- This ensures we account for multiple transactions
-- and treat them as a single sector exposure.

WITH sector_totals AS (
    SELECT
        investor_id,
        sector_id,
        SUM(no_of_shares) AS sector_shares
    FROM investor_transactions
    GROUP BY investor_id, sector_id
),

-- Step 2:
-- Compute the total number of shares held by each investor.
-- This represents the overall portfolio size
-- that well use as the base for percentage calculation.
  
investor_totals AS (
    SELECT
        investor_id,
        SUM(no_of_shares) AS total_shares
    FROM investor_transactions
    GROUP BY investor_id
)
  
-- Final Step:
-- Join both aggregations with the sectors reference table
-- and calculate each sectors proportional weight
-- within the investors total portfolio
  
SELECT
    st.investor_id,
    s.sector_name,
    (st.sector_shares * 100.0 / it.total_shares) AS percentage
FROM sector_totals st
JOIN investor_totals it
    ON st.investor_id = it.investor_id
JOIN sectors s
    ON st.sector_id = s.sector_id
ORDER BY
    st.investor_id,
    s.sector_name;
