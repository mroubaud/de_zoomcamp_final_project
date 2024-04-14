select *,
from {{ source('staging', 'match_sequence_table') }}
where team_id is not null

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 10000000

{% endif %}