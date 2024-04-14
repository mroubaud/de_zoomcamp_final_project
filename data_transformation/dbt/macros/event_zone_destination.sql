{#
    This macro returns the zone of the pitch where tha event happened or ends
    If the event has no x,relative_event__y coordinates of the pitch, it returns null
#}

{% macro get_event_zone_destination(relative_event__x, relative_event__y) -%}

    case 
        --when null then null
        when ((0 <= relative_event__y) AND  (relative_event__y < 0.17)) then 
            case 
                --when null then null
                when ((0 <= relative_event__x) AND (relative_event__x < 0.33)) then "Z1"
                when ((0.33 <= relative_event__x) AND (relative_event__x < 0.67)) then "Z2"
                when ((0.67 <= relative_event__x) AND (relative_event__x <= 1)) then "Z3"
                else null
            end
        when ((0.17 <= relative_event__y) AND (relative_event__y < 0.33)) then 
            case     
                --when null then null
                when ((0 <= relative_event__x) AND (relative_event__x < 0.33)) then "Z4"
                when ((0.33 <= relative_event__x) AND (relative_event__x < 0.67)) then "Z5"
                when ((0.67 <= relative_event__x) AND (relative_event__x <= 1)) then "Z6"
                else null
            end 
        when ((0.33 <= relative_event__y) AND  (relative_event__y < 0.5)) then 
            case 
                --when null then null
                when ((0 <= relative_event__x) AND (relative_event__x < 0.33)) then "Z7"
                when ((0.33 <= relative_event__x) AND (relative_event__x < 0.67)) then "Z8"
                when ((0.67 <= relative_event__x) AND (relative_event__x <= 1)) then "Z9"
                else null
            end
        when ((0.5 <= relative_event__y) AND (relative_event__y < 0.67)) then 
            case 
                --when null then null
                when ((0 <= relative_event__x) AND (relative_event__x < 0.33)) then "Z10"
                when ((0.33 <= relative_event__x) AND (relative_event__x < 0.67)) then "Z11"
                when ((0.67 <= relative_event__x) AND (relative_event__x <= 1)) then "Z12"
                else null
            end
        when ((0.67 <= relative_event__y) AND (relative_event__y < 0.83)) then 
            case 
                --when null then null
                when ((0 <= relative_event__x) AND (relative_event__x < 0.33)) then "Z13"
                when ((0.33 <= relative_event__x) AND (relative_event__x < 0.67)) then "Z14"
                when ((0.67 <= relative_event__x) AND (relative_event__x <= 1)) then "Z15"
                else null
            end
        when ((0.83 <= relative_event__y) AND (relative_event__y <= 1)) then 
            case 
                ----when null then null
                when ((0 <= relative_event__x) AND (relative_event__x < 0.33)) then "Z16"
                when ((0.33 <= relative_event__x) AND (relative_event__x < 0.67)) then "Z17"
                when ((0.67 <= relative_event__x) AND (relative_event__x <= 1)) then "Z18"
                else null
            end
        else null
    end

{%- endmacro %}