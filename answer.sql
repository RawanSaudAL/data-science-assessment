SELECT
  it.investor_id,
  s.sector_name,
  ROUND(
    100.0 * it.no_of_shares
    / SUM(it.no_of_shares) OVER (PARTITION BY it.investor_id),
    2
  ) AS percentage
FROM investor_transactions it
JOIN sectors s
  ON s.sector_id = it.sector_id
ORDER BY it.investor_id, percentage DESC;
