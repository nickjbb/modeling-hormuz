import requests
import time
from datetime import date, timedelta

class EIAClient:
    def __init__(self, api_key: str, identifier: str = None):
        self.api_key = api_key
        self.base_url = "https://api.eia.gov/v2/"
        self.identifier = identifier
        self.frequency = "daily"

    def set_dataset(self, dataset_id: str) -> None:

        self.base_url = "https://api.eia.gov/v2/"

        match dataset_id:
            case "brent_crude":
                self.base_url += "petroleum/pri/spt/data/"
                self.identifier = "RBRTE"
                self.frequency = "daily"
            case "wti_crude":
                self.base_url += "petroleum/pri/spt/data/"
                self.identifier = "RWTC"
                self.frequency = "daily"
            case "natural_gas":
                self.base_url += "naturalgas/"
                self.identifier = "RNG"
                self.frequency = "daily"
            case "gasoline":
                self.base_url += "petroleum/pri/gnd/data/"
                self.identifier = "EMM_EPM0_PTE_NUS_DPG"
                self.frequency = "weekly"
            case _:
                raise ValueError(f"Unsupported dataset_id: {dataset_id}")

    def get_data(self, start_date=(date.today() - timedelta(weeks=1)).strftime("%Y-%m-%d"), end_date=date.today().strftime("%Y-%m-%d")) -> dict:

        params = {
            "api_key": self.api_key,
            "frequency": self.frequency,
            "data[0]": "value",
            "facets[series][]": self.identifier,
            "start": start_date,
            "end": end_date,
            "sort[0][column]": "period",
            "sort[0][direction]": "desc"
        }
        response = requests.get(self.base_url, params=params)
        if response.status_code == 200:
            return response.json()
        else:
            response.raise_for_status()

if __name__ == "__main__":
    import os
    from dotenv import load_dotenv

    load_dotenv()
    api_key = os.getenv("EIA_API_KEY")
    eia_client = EIAClient(api_key, "RBRTE")
    eia_client.set_dataset("brent_crude")

    print(eia_client.get_data(start_date="2024-01-01", end_date="2024-01-02"))