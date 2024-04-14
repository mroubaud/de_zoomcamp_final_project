select 
    _dlt_list_idx,
    _dlt_id,
    _dlt_parent_id,
    value,
from {{ source('staging', 'match_sequence_table__event_ids') }}


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 10000000

{% endif %}