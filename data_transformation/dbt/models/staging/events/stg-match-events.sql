select *,
from {{ source('staging', 'match_events_table') }}


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100000000

{% endif %}