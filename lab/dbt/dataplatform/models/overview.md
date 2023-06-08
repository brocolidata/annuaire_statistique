{% docs __overview__ %}

# Data Catalog of the *Annuaire Statistique du Maroc*

**Data Provider** : [hcp.ma](https://www.hcp.ma/downloads/?tag=Annuaires+statistiques+du+Maroc+%28Format+Excel%29)

**Maintainer** : Brocoli Data

## Navigation
You can use the Project and Database navigation tabs on the left side of the window to explore the available data assets.

### *Project* Tab
It mirrors the directory structure of the dbt project.

### *Database* Tab
A database explorer, showing relations (tables and views) grouped into database schemas.

There are 3 databases : 
- `raw` : where raw data is stored.
- `stg` : where data is first staged to be transformed in database
- `ods` : where data is transformed to represent clean entities. The data of the models stored in this database are available as `.csv` files in GitHub.

### *Group* Tab
Explore models organized by logical groups.

The groups represent the different chapters of the Statistical Yearbook :
- `indice_des_prix` : Price index data

## Graph Exploration
You can click the blue icon on the bottom-right corner of the page to view the lineage graph of the models.

{% enddocs %}