{#
    This macro returns the distance of an event pass.
    If the event is not a pass, it returns null
#}

{% macro get_pass_distance(x, y, relative_event__x, relative_event__y) -%}

    If( IFNULL(null, relative_event__x) = relative_event__x, round( sqrt(power(x-relative_event__x,2)*68 + power(y-relative_event__y,2)*105), 2 ), null )

{%- endmacro %}