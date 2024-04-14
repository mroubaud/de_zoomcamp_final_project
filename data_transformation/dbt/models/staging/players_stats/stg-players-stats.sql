select *,
from {{ source('staging', 'match_players_stats_table') }}


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 10000000

{% endif %}