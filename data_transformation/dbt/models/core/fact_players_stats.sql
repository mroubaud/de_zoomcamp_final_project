with players_stats_info as (
    select *,
    from {{ ref("stg-players-stats-info") }}
),
players_stats as (
    select *,
    from {{ ref("stg-players-stats")}}
),
players as (
    select *,
    from {{ ref("players") }}
),
teams as (
    select *,
    from {{ ref("teams") }}
)
select 
    players_stats_info._dlt_id,
    players_stats_info.player_id,
    players_stats_info.stats__goal,
    players_stats_info.stats__total_shot,
    players_stats_info.stats__shot_on_target,
    players_stats_info.stats__shot_off_target,
    players_stats_info.stats__shot_blocked,
    players_stats_info.stats__shot_in_pa,
    players_stats_info.stats__shot_outside_of_pa,
    players_stats_info.stats__free_kick,
    players_stats_info.stats__corner_kick,
    players_stats_info.stats__throw_in,
    players_stats_info.stats__penalty_kick,
    players_stats_info.stats__pass,
    players_stats_info.stats__pass_succeeded,
    players_stats_info.stats__pass_failed,
    players_stats_info.stats__assist,
    players_stats_info.stats__key_pass,
    players_stats_info.stats__control_under_pressure,
    players_stats_info.stats__cross,
    players_stats_info.stats__cross_succeeded,
    players_stats_info.stats__final_third_area_pass,
    players_stats_info.stats__final_third_area_pass_succeeded,
    players_stats_info.stats__middle_area_pass,
    players_stats_info.stats__middle_area_pass_succeeded,
    players_stats_info.stats__defensive_area_pass,
    players_stats_info.stats__defensive_area_pass_succeeded,
    players_stats_info.stats__short_pass,
    players_stats_info.stats__medium_range_pass,
    players_stats_info.stats__medium_range_pass_succeeded,
    players_stats_info.stats__long_pass,
    players_stats_info.stats__long_pass_succeeded,
    players_stats_info.stats__forward_pass,
    players_stats_info.stats__forward_pass_succeeded,
    players_stats_info.stats__backward_pass,
    players_stats_info.stats__backward_pass_succeeded,    
    players_stats_info.stats__sideways_pass,
    players_stats_info.stats__sideways_pass_succeeded,
    players_stats_info.stats__tackle,
    players_stats_info.stats__tackle_succeeded,
    players_stats_info.stats__aerial_duel,
    players_stats_info.stats__aerial_duel_succeeded,
    players_stats_info.stats__aerial_duel_failed,
    players_stats_info.stats__ground_duel,
    players_stats_info.stats__ground_duel_succeeded,
    players_stats_info.stats__ground_duel_failed,
    players_stats_info.stats__loose_ball_duel,
    players_stats_info.stats__loose_ball_duel_succeeded,
    players_stats_info.stats__loose_ball_duel_failed,
    players_stats_info.stats__intercept,
    players_stats_info.stats__clearance,
    players_stats_info.stats__recovery,
    players_stats_info.stats__intervention,
    players_stats_info.stats__take_on,
    players_stats_info.stats__take_on_succeeded,
    players_stats_info.stats__mistake,
    players_stats_info.stats__block,
    players_stats_info.stats__foul,
    players_stats_info.stats__foul_won,
    players_stats_info.stats__offside,
    players_stats_info.stats__yellow_card,
    players_stats_info.stats__red_card,
    players_stats_info.stats__own_goal,
    players_stats_info.stats__goal_conceded,
    players_stats_info.stats__goal_kick,
    players_stats_info.stats__goal_kick_succeeded,
    players_stats_info.stats__aerial_clearance,
    players_stats_info.stats__aerial_clearance_succeeded,
    players_stats_info.stats__aerial_clearance_failed,
    players_stats_info.stats__defensive_line_support,
    players_stats_info.stats__defensive_line_support_succeeded,
    players_stats_info.stats__defensive_line_support_failed,
    players_stats_info.stats__save_by_catching,
    players_stats_info.stats__save_by_punching,
    players_stats_info.stats__rating,
    players_stats_info.stats__play_time,
    players_stats.team_id,
    players_stats.match_id,
    players.player_full_name,
    players.main_position,
    teams.team_name
from players_stats_info
inner join players_stats
on players_stats._dlt_id = players_stats_info._dlt_parent_id
inner join players
on players_stats_info.player_id = players.player_id
inner join teams
on players_stats.team_id = teams.team_id