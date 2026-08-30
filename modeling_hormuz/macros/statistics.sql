-- Moving Statistics
{% macro two_unit_average(date_column, value_column) %}
    avg({{value_column}}) over (order by {{ date_column }} rows between 1 preceding and current row)
{% endmacro %}

{% macro seven_unit_average(date_column, value_column) %}
    avg({{value_column}}) over (order by {{ date_column }} rows between 6 preceding and current row)
{% endmacro %}

{% macro thirty_unit_average(date_column, value_column) %}
    avg({{ value_column }}) over (order by {{ date_column }} rows between 29 preceding and current row)
{% endmacro %}

{% macro two_unit_max(date_column, value_column) %}
    max({{ value_column }}) over (order by {{ date_column }} rows between 1 preceding and current row)
{% endmacro %}

{% macro seven_unit_max(date_column, value_column) %}
    max({{ value_column }}) over (order by {{ date_column }} rows between 6 preceding and current row)
{% endmacro %}

{% macro thirty_unit_max(date_column, value_column) %}
    max({{ value_column }}) over (order by {{ date_column }} rows between 29 preceding and current row)
{% endmacro %}

{% macro two_unit_min(date_column, value_column) %}
    min({{ value_column }}) over (order by {{ date_column }} rows between 1 preceding and current row)
{% endmacro %}

{% macro seven_unit_min(date_column, value_column) %}
    min({{ value_column }}) over (order by {{ date_column }} rows between 6 preceding and current row)
{% endmacro %}

{% macro thirty_unit_min(date_column, value_column) %}
    min({{ value_column }}) over (order by {{ date_column }} rows between 29 preceding and current row)
{% endmacro %}