{#
    This macro returns the full name of the player given his first name and last name
#}

{% macro get_player_full_name(player_name, player_last_name) -%}
    concat(player_name, " ", player_last_name)
{%- endmacro %}
