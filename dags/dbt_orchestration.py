from airflow.sdk import DAG, task
from airflow.providers.standard.operators.bash import BashOperator
from airflow.providers.standard.operators.python import PythonOperator
from datetime import datetime, timedelta
from src.data_ingestion import run_pipeline

with DAG(
    "ingestion_and_dbt_pipeline",
    "Raw Data Ingestion + DBT Pipeline Orchestration",
    {
        "depends_on_past": False,
        "retries": 2,
        "retry_delay": timedelta(minutes=10)
    },
    schedule=timedelta(weeks=1),
    start_date=datetime(2026, 9, 2),
    catchup=False,
    tags=["analytics", "hormuz", "ingestion"],
) as dag:

    t1 = PythonOperator(task_id="data_ingestion", python_callable=run_pipeline)
    t2 = BashOperator(
        task_id="dbt-build",
        bash_command="dbt build",
        retries=1
    )

    t1 >> t2