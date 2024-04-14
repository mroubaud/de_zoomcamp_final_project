select *,
from {{ source('staging', 'match_events_table__event_types') }}


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 10000000000

{% endif %}