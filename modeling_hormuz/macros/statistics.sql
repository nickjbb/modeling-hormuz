-- Moving Statistics
{% macro 2_unit_average(date_column, value_column) %}
    avg({{value_column}}) over (order by {{ date_column }} rows between 1 preceding and current row)
{% endmacro %}

{% macro 7_unit_average(date_column, value_column) %}
    avg({{value_column}}) over (order by {{ date_column }} rows between 6 preceding and current row)
{% endmacro %}

{% macro 30_unit_average(date_column, value_column) %}
    avg({{ value_column }}) over (order by {{ date_column }} rows between 30 preceding and current row)
{% endmacro %}

{% macro 2_unit_max(date_column, value_column) %}
    max({{ value_column }}) over (order by {{ date_column }} rows between 1 preceding and current row)
{% endmacro %}

{% macro 7_unit_max(date_column, value_column) %}
    max({{ value_column }}) over (order by {{ date_column }} rows between 6 preceding and current row)
{% endmacro %}

{% macro 30_unit_max(date_column, value_column) %}
    max({{ value_column }}) over (order by {{ date_column }} rows between 30 preceding and current row)
{% endmacro %}

{% macro 2_unit_min(date_column, value_column) %}
    min({{ value_column }}) over (order by {{ date_column }} rows between 1 preceding and current row)
{% endmacro %}

{% macro 7_unit_min(date_column, value_column) %}
    min({{ value_column }}) over (order by {{ date_column }} rows between 6 preceding and current row)
{% endmacro %}

{% macro 30_unit_min(date_column, value_column) %}
    min({{ value_column }}) over (order by {{ date_column }} rows between 30 preceding and current row)
{% endmacro %}