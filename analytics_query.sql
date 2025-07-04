CREATE OR REPLACE TABLE `tough-access-464904-v5.uber_data_engineering_yt.tbl_analytics` AS (
  SELECT
    f.trip_id,
    f.miles_x,
    f.duration_x,
    f.speed_x,
    f.day_x,
    f.day_time_x,

    -- Start Date Info
    sd.start_date,

    -- End Date Info
    ed.end_date,

    -- Start & End Location Info
    sl.start_location_id AS start_location_name,
    el.end_location_id AS end_location_name,

    -- Category and Purpose Info
    c.category,
    p.purpose

  FROM `tough-access-464904-v5.uber_data_engineering_yt.fact_table` f
  LEFT JOIN `tough-access-464904-v5.uber_data_engineering_yt.start_date` sd
    ON f.start_date = sd.start_date
  LEFT JOIN `tough-access-464904-v5.uber_data_engineering_yt.end_date` ed
    ON f.end_date = ed.end_date
  LEFT JOIN `tough-access-464904-v5.uber_data_engineering_yt.start_location_id` sl
    ON f.start_location_id = sl.start_location_id
  LEFT JOIN `tough-access-464904-v5.uber_data_engineering_yt.end_location_id` el
    ON f.end_location_id = el.end_location_id
  LEFT JOIN `tough-access-464904-v5.uber_data_engineering_yt.category` c
    ON f.category = c.category
  LEFT JOIN `tough-access-464904-v5.uber_data_engineering_yt.purpose` p
    ON f.purpose = p.purpose
);