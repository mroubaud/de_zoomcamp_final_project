with players as (
    select *,
    from {{ ref("players") }}
),
teams as (
    select *,
    from {{ ref("teams")}}
),
matches as (
    select *,
    from {{ ref('matches')}}
),
match_events as (
    select *,
        {{ get_event_min("event_time","event_period") }} as event_min,
        {{ get_event_min("relative_event__event_time","event_period") }} as relative_event__event_min,
        {{ get_pass_distance("x", "y", "relative_event__x", "relative_event__y") }} as pass_distance,
        {{ get_event_zone("x", "y") }} as event_zone,
        {{ get_event_zone("relative_event__x", "relative_event__y") }} as event_zone_destination,
    from {{ ref('stg-match-events') }}
),
match_event_types as (
    select *,
    from {{ ref('stg-match-event-types') }}
)
select 
    match_events.id as event_id,
    match_events.event_period,
    match_events.event_time,
    match_events.event_min,
    match_events.match_id,
    match_events.team_id,
    match_events.player_id,
    match_events.x,
    match_events.y,
    match_events.relative_event__id,
    match_events.relative_event__event_time,
    match_events.relative_event__event_min,
    match_events.relative_event__player_id,
    match_events.relative_event__x,
    match_events.relative_event__y,
    match_events.pass_distance,
    match_events.xg,
    match_events.event_zone,
    match_events.event_zone_destination,
    match_event_types.event_type,
    match_event_types.outcome,
    match_event_types.`cross`,
    match_event_types.key_pass,
    match_event_types.assist,
    match_event_types.sub_event_type,
    match_event_types.body_part,
    match_event_types._dlt_id,
    match_event_types._dlt_parent_id,
    match_event_types._dlt_list_idx,
    players.player_full_name,
    players.back_number,
    players.main_position,
    teams.team_name,
    matches.start_time,
    matches.home_team__id,
    matches.home_team_name,
    matches.away_team__id,
    matches.away_team_name,
    matches.home_team_score,
    matches.away_team_score,
from match_events 
inner join match_event_types
on match_events._dlt_id = match_event_types._dlt_parent_id
inner join players
on match_events.player_id = players.player_id
inner join teams
on match_events.team_id = teams.team_id
inner join matches
on match_events.match_id = matches.match_id