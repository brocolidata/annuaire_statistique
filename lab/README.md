# Instructions for using this DataPlatform Lab

- **Data Source** : [Annuaire Statistique du Maroc](https://www.hcp.ma/downloads/?tag=Annuaires+statistiques+du+Maroc+%28Format+Excel%29)
- **Data Provider** : [https://www.hcp.ma/](HCP)
- **Source Data Format** : RAR archives containing `.xlsx` files

## Extract data

### 1. Download files archives
Run the [`data_import.ipynb`](notebooks/data_import.ipynb) notebook to download all available RAR archives in the [extract](dwh_data/extract) folder

### 2. Extract data from `.xlsx` files
Run the [`extract_Indice_des_prix.ipynb`](notebooks/extract_Indice_des_prix.ipynb) notebook to extract all tables in `.xlsx` and load them as `.parquet` files in the [raw](dwh_data/raw) folder

## Transform data


## Development

### Generate `.yml` documentation for a dbt model
```
make generate_doc model=MODEL
```
where `MODEL` is the name of the dbt model for which you want to generate doc


