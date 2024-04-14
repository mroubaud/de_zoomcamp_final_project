{#
    This macro returns the minute of the match when the event event heppened
    the event time is received in milisecods and is relative to the quick off of the game
#}

{% macro get_event_min(event_time, event_period) -%}

    case event_period  
        when "FIRST_HALF" then round(event_time/(60*1000),0)
        when "SECOND_HALF" then round((event_time-2700000)/(60*1000),0)
        when "EXTRA_FIRST_HALF" then round((event_time-5400000)/(60*1000),0)
        when "EXTRA_SECOND_HALF" then round((event_time-6300000)/(60*1000),0)
        when "PSO" then 120
        else NULL
    end

{%- endmacro %}
