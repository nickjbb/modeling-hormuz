import dotenv
dotenv.load_dotenv()
import requests
import pandas as pd
import os
import json
from EIAClient import EIAClient
from datetime import date, timedelta

def extract_data_from_api(api_url: str, id: str, start_time: str, end_time: str) -> list[dict]:
    """
    Extracts data from the specified API URL.

    Args:
        api_url (str): The URL of the API endpoint.
    """

    try:
        eia_client = EIAClient(os.getenv('EIA_API_KEY'))
        eia_client.set_dataset(id)
        data = eia_client.get_data(start_time, end_time)
        return data['response']['data']
    except ValueError as e:
        return f"ValueError: {e}"


def transform_data(data) -> pd.DataFrame:
    """
    Transforms the extracted data into a pandas DataFrame.

    Args:
        data (list): The extracted data in list format.
        table_name (str): The name of the target table in the database.

    Returns:
        pd.DataFrame: The transformed data as a pandas DataFrame.
    """

    if not data:
        return pd.DataFrame()
    
    df = pd.json_normalize(data)

    df['ingested_at'] = pd.Timestamp.now()

    print(df.head())
    return df



def load_data(df: pd.DataFrame, conn_string: str, table_name: str) -> None:
    """
    Loads the transformed data into a PostgreSQL database.

    Args:
        df (pd.DataFrame): The transformed data as a pandas DataFrame.
        conn_string (str): The connection string for the PostgreSQL database.
        table_name (str): The name of the target table in the database.
    """
    if df.empty:
        print("No data to load. The DataFrame is empty.")
        return
    try:
        df.to_sql(name=f"{table_name}".lower(), schema='raw', con=conn_string, if_exists='append', index=False)
        print(f"Data loaded successfully into table '{table_name}'.")
    except Exception as e:
        print(f"Error occurred while loading data into database: {e}")

def run_pipeline(api_url: str, conn_string: str, table_name: str) -> None:
    """
    Runs the entire ETL pipeline: extract, transform, and load.

    Args:
        api_url (str): The URL of the API endpoint.
        conn_string (str): The connection string for the PostgreSQL database.
        table_name (str): The name of the target table in the database.
    """

    print("Running pipeline...")
    raw_data = extract_data_from_api(api_url, table_name, (date.today() - timedelta(weeks=33)).strftime("%Y-%m-%d"), date.today())
    transformed_data = transform_data(raw_data)
    load_data(transformed_data, conn_string, table_name)
    print("Pipeline successfully completed.")

if __name__ == "__main__":
    # Example usage
    CONN_STRING = f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
    TABLE_NAMES = os.getenv('TABLE_NAMES').split(',')

    for table in TABLE_NAMES:
        run_pipeline(os.getenv('EIA_API_KEY'), CONN_STRING, table)