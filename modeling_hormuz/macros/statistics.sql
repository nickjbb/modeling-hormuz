{% macro weekly_average(date_column, value_column) %}
    avg({{value_column}}) over (order by {{ date_column }} rows between 6 preceding and current row)
{% endmacro %}

{% macro monthly_average(date_column, value_column) %}
    avg({{ value_column }}) over (order by {{ date_column }} rows between 30 preceding and current row)
{% endmacro %}

{% macro weekly_max(date_column, value_column) %}
    max({{ value_column }}) over (order by {{ date_column }} rows between 6 preceding and current row)
{% endmacro %}

{% macro monthly_max(date_column, value_column) %}
    max({{ value_column }}) over (order by {{ date_column }} rows between 30 preceding and current row)
{% endmacro %}

{% macro weekly_min(date_column, value_column) %}
    min({{ value_column }}) over (order by {{ date_column }} rows between 6 preceding and current row)
{% endmacro %}

{% macro monthly_min(date_column, value_column) %}
    min({{ value_column }}) over (order by {{ date_column }} rows between 30 preceding and current row)
{% endmacro %}