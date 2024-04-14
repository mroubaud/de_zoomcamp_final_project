select 
    id as player_id,
    player_name_en as player_name,
    player_last_name_en as player_last_name,
    {{ get_player_full_name("player_name","player_last_name") }} as player_full_name,
    back_number,
    main_position,
    team_id,
from {{ ref("seed_players") }}
