import dotenv
dotenv.load_dotenv()
import requests
import pandas as pd
import os
import json

def extract_data_from_api(api_url: str):
    """
    Extracts data from the specified API URL.

    Args:
        api_url (str): The URL of the API endpoint.
    """

    try:
        response = requests.get(
            api_url,
            headers={"Authorization": f"Token {os.getenv('OIL_PRICE_API_KEY')}"},
            timeout=10
        )
        response.raise_for_status()  # Raise an exception for HTTP errors
        return response.json()  # Assuming the API returns JSON data
    except requests.exceptions.RequestException as e:
        print(f"Error occurred while fetching data from API: {e}")
        return []


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

    if data['status'] != 'success':
        print("Data extraction was not successful. Please check the API response.")
        return pd.DataFrame()
    
    df = pd.json_normalize(data, record_path=['data', 'prices'], meta=['status'])

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
    raw_data = extract_data_from_api(api_url)
    transformed_data = transform_data(raw_data)
    load_data(transformed_data, conn_string, table_name)
    print("Pipeline successfully completed.")

if __name__ == "__main__":
    # Example usage
    API_URL_TEMPLATE = "https://api.oilpriceapi.com/v1/prices/past_day?by_code={}"
    CONN_STRING = f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
    TABLE_NAMES = os.getenv('TABLE_NAMES').split(',')

    for table_name in TABLE_NAMES:
        api_url = API_URL_TEMPLATE.format(table_name)
        run_pipeline(api_url, CONN_STRING, table_name)