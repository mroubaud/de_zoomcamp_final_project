{#
    This macro returns the Zone of the pitch where tha event happened or ends
    If the event has no x,y coordinates of the pitch, it returns null
#}

{% macro get_event_zone(x, y) -%}

    case 
        --when null then null
        when ((0 <= y) AND  (y < 0.17)) then 
            case 
                --when null then null
                when ((0 <= x) AND (x < 0.33)) then "Z1"
                when ((0.33 <= x) AND (x < 0.67)) then "Z2"
                when ((0.67 <= x) AND (x <= 1)) then "Z3"
                else null
            end
        when ((0.17 <= y) AND (y < 0.33)) then 
            case     
                --when null then null
                when ((0 <= x) AND (x < 0.33)) then "Z4"
                when ((0.33 <= x) AND (x < 0.67)) then "Z5"
                when ((0.67 <= x) AND (x <= 1)) then "Z6"
                else null
            end 
        when ((0.33 <= y) AND  (y < 0.5)) then 
            case 
                --when null then null
                when ((0 <= x) AND (x < 0.33)) then "Z7"
                when ((0.33 <= x) AND (x < 0.67)) then "Z8"
                when ((0.67 <= x) AND (x <= 1)) then "Z9"
                else null
            end
        when ((0.5 <= y) AND (y < 0.67)) then 
            case 
                --when null then null
                when ((0 <= x) AND (x < 0.33)) then "Z10"
                when ((0.33 <= x) AND (x < 0.67)) then "Z11"
                when ((0.67 <= x) AND (x <= 1)) then "Z12"
                else null
            end
        when ((0.67 <= y) AND (y < 0.83)) then 
            case 
                --when null then null
                when ((0 <= x) AND (x < 0.33)) then "Z13"
                when ((0.33 <= x) AND (x < 0.67)) then "Z14"
                when ((0.67 <= x) AND (x <= 1)) then "Z15"
                else null
            end
        when ((0.83 <= y) AND (y <= 1)) then 
            case 
                ----when null then null
                when ((0 <= x) AND (x < 0.33)) then "Z16"
                when ((0.33 <= x) AND (x < 0.67)) then "Z17"
                when ((0.67 <= x) AND (x <= 1)) then "Z18"
                else null
            end
        else null
    end

{%- endmacro %}