SELECT
  it.investor_id,
  s.sector_name,
  ROUND(
    (SUM(it.no_of_shares) * 100.0) /
    SUM(SUM(it.no_of_shares)) OVER (PARTITION BY it.investor_id),
    2
  ) AS percentage
FROM investor_transactions it
JOIN sectors s
  ON s.sector_id = it.sector_id
GROUP BY
  it.investor_id,
  s.sector_name
ORDER BY
  it.investor_id,
  s.sector_name;
