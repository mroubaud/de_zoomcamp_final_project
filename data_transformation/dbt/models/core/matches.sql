select 
    id as match_id,
    start_time,
    home_team__id,
    home_team__name_en as home_team_name,
    away_team__id,
    away_team__name_en as away_team_name,
    detail_match_result__home_team_score as home_team_score,
    detail_match_result__away_team_score as away_team_score,
from {{ ref("seed_matches") }}