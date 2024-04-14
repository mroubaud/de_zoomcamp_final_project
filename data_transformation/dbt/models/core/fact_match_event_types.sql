select *,
from {{ ref("stg-match-event-types") }}

   