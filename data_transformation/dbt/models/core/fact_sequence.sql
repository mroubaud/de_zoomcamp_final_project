select 
    sequence_id,
    start_time,
    end_time,
    event_period,
    match_id,
    team_id,
    _dlt_id,
    _dlt_load_id,
from {{ ref('stg-sequence') }}


