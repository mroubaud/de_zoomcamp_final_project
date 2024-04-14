select 
    id as team_id,
    name_en as team_name,
from {{ ref("seed_teams") }}