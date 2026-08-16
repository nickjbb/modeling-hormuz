{% macro daily_average(table_name, date_column, value_column) %}
    (select
        avg({{ value_column }}) as daily_avg
    from {{ table_name }}
    where date_trunc('day', {{ date_column }}) = date_trunc('day', current_date))
{% endmacro %}

{% macro weekly_average(table_name, date_column, value_column) %}
    (select
        avg({{ value_column }}) as weekly_avg
    from {{ table_name }}
    where date_trunc('week', {{ date_column }}) = date_trunc('week', current_date))
{% endmacro %}

{% macro monthly_average(table_name, date_column, value_column) %}
    (select
        avg({{ value_column }}) as monthly_avg
    from {{ table_name }}
    where date_trunc('month', {{ date_column }}) = date_trunc('month', current_date))
{% endmacro %}

{% macro daily_max(table_name, date_column, value_column) %}
    (select
        max({{ value_column }}) as daily_max
    from {{ table_name }}
    where date_trunc('day', {{ date_column }}) = date_trunc('day', current_date))
{% endmacro %}

{% macro weekly_max(table_name, date_column, value_column) %}
    (select
        max({{ value_column }}) as weekly_max
    from {{ table_name }}
    where date_trunc('week', {{ date_column }}) = date_trunc('week', current_date))
{% endmacro %}

{% macro monthly_max(table_name, date_column, value_column) %}
    (select
        max({{ value_column }}) as monthly_max
    from {{ table_name }}
    where date_trunc('month', {{ date_column }}) = date_trunc('month', current_date))
{% endmacro %}

{% macro daily_min(table_name, date_column, value_column) %}
    (select
        min({{ value_column }}) as daily_min
    from {{ table_name }}
    where date_trunc('day', {{ date_column }}) = date_trunc('day', current_date))
{% endmacro %}

{% macro weekly_min(table_name, date_column, value_column) %}
    (select
        min({{ value_column }}) as weekly_min
    from {{ table_name }}
    where date_trunc('week', {{ date_column }}) = date_trunc('week', current_date))
{% endmacro %}

{% macro monthly_min(table_name, date_column, value_column) %}
    (select
        min({{ value_column }}) as monthly_min
    from {{ table_name }}
    where date_trunc('month', {{ date_column }}) = date_trunc('month', current_date))
{% endmacro %}