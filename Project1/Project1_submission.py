# 2019-CE-04 SABA

def query_one():
    """Query for Stanford's venue"""
    return 
    """
       SELECT
         venue_name,
         venue_capacity
       FROM
         `bigquery-public-data.ncaa_basketball.mbb_teams`
       WHERE
         turner_name = 'Stanford University'
    """

def query_two():
    """Query for games in Stanford's venue"""
    return """
     SELECT
        COUNT(venue_name) AS games_at_maples_pavilion
     FROM
       `bigquery-public-data.ncaa_basketball.mbb_games_sr`
     WHERE
       venue_city = "Stanford"
       AND season = 2013
    """

def query_three():
    """Query for maximum-red-intensity teams"""
    return 
    """
       SELECT
         market,
         color
       FROM
        `bigquery-public-data.ncaa_basketball.team_colors`
       WHERE
        color LIKE '#ff%'
        OR color LIKE '#FF%'
      ORDER BY
        market
    """

def query_four():
    """Query for Stanford's wins at home"""
    return 
    """
     SELECT
      COUNT (game_id),
      ROUND(AVG(h_points), 2),
      ROUND (AVG (a_points), 2)
    FROM
     `bigquery-public-data.ncaa_basketball.mbb_games_sr`
    WHERE
      h_market = 'Stanford'
      AND h_points > a_points
      AND season >= 2013
      AND season <= 2017
    """

def query_five():
    """Query for players for birth city"""
    return """
     SELECT
        COUNT(DISTINCT player_id) AS num_players
     FROM
       `bigquery-public-data.ncaa_basketball.mbb_players_games_sr`
    JOIN
      `bigquery-public-data.ncaa_basketball.mbb_teams`
    ON
      market = team_market
   WHERE
     birthplace_city = venue_city
     AND birthplace_state = venue_state
    """

def query_six():
    """Query for biggest blowout"""
    return """
    SELECT
       win_name,
       lose_name,
       win_pts,
       lose_pts,
      (win_pts-lose_pts) AS margin
    FROM
      `bigquery-public-data.ncaa_basketball.mbb_historical_tournament_games`
    WHERE
      (win_pts-lose_pts) = (
    SELECT
      MAX(win_pts-lose_pts)
    FROM
     `bigquery-public-data.ncaa_basketball.mbb_historical_tournament_games`)
    """

def query_seven():
    """Query for historical upset percentage"""
    return """
       SELECT
         ROUND(COUNT(win_seed)*100/(
      SELECT
        COUNT(win_seed)
      FROM
       `bigquery-public-data.ncaa_basketball.mbb_historical_tournament_games`),2 )
      FROM
       `bigquery-public-data.ncaa_basketball.mbb_historical_tournament_games`
      WHERE
       win_seed > lose_seed
    """

def query_eight():
    """Query for teams with same states and colors"""
    return 
    """
     SELECT
        a.name,
        c.name,
        a.venue_state
    FROM
       `bigquery-public-data.ncaa_basketball.mbb_teams` a
    JOIN
      `bigquery-public-data.ncaa_basketball.team_colors` b
    ON
      a.code_ncaa = b.code_ncaa,
     `bigquery-public-data.ncaa_basketball.mbb_teams` c
   JOIN
    `bigquery-public-data.ncaa_basketball.team_colors` d
   ON
     c.code_ncaa = d.code_ncaa
  WHERE
    a.venue_state = c.venue_state
    AND b.color = d.color
    AND a.name < c.name
  ORDER BY
    a.name
    """

def query_nine():
    """Query for top geographical locations"""
    return """
       SELECT
        birthplace_city AS city,
        birthplace_state AS state,
        birthplace_country As country,
        SUM (points) As total_points
      FROM
        `bigquery-public-data.ncaa_basketball.mbb_players_games_sr`
      WHERE
        team_market = 'Stanford'
      GROUP BY
        birthplace_city,
        birthplace_state,
        birthplace_country
      ORDER BY
       SUM(points) DESC
     LIMIT
       3
    """

def query_ten():
    """Query for teams with lots of high-scorers"""
    return """
       SELECT
         team_market,
         COUNT(*) AS num_players
      FROM (
        SELECT
         DISTINCT player_id,
         team_market
        FROM
        `bigquery-public-data.ncaa_basketball.mbb_pbp_sr`
        WHERE
         season >= 2013
         AND period = 1
       GROUP BY
        game_id,
        player_id,
        team_market
       HAVING
      SUM(points_scored) >= 15)
    GROUP BY
      team_market
   HAVING
     COUNT (*) > 5
   ORDER BY
    COUNT(*) DESC,
    team_market
  LIMIT
    5
    """

def query_eleven():
    """Query for highest-winner teams"""
    return """
      SELECT
         market AS team_market,
        COUNT(*) AS top_performer_count
     FROM (
        SELECT
        season,
        MAX(wins) wins
    FROM
       `bigquery-public-data.ncaa_basketball.mbb_historical_teams_seasons` s1
    WHERE
       season >= 1900
       AND season <= 2000
   GROUP BY
      season) s1
   JOIN
     `bigquery-public-data.ncaa_basketball.mbb_historical_teams_seasons` s2
   ON
     s1.season = s2.season
  WHERE
    s1.wins = s2.wins
    AND market IS NOT NULL
  GROUP BY
    market
  ORDER BY
    COUNT(*) DESC,
    market
  LIMIT
    5
    """