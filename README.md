# Annuaire Statistique

[![Open in Codespace](https://img.shields.io/static/v1?label=Codespace&message=Open&color=blue&logo=github)](https://github.com/codespaces/new?template_repository=brocolidata/annuaire_statistique)

Curated moroccan data from HCP's statistical yearbook (*Annuaire statistique*)

**Source** : [hcp.ma](https://www.hcp.ma/downloads/?tag=Annuaires+statistiques+du+Maroc+%28Format+Excel%29)

**See our [(dbt) Data Catalog](https://brocolidata.github.io/annuaire_statistique/)**



We use a Data Platform composed of : 
- Jupyter notebooks for extracting & loading data.
- [dbt](https://www.getdbt.com) for data transformation.
- [DuckDB](https://duckdb.org) as a (in-process) DataWarehouse.

## Quickstart

### Local

*Make sure you meet all [Prerequisites for local development](#prerequisites-for-local-development)* 
1. Click on this badge [![Create Repository from template](https://img.shields.io/static/v1?label=GitHub&message=Create%20Repository&color=blue&logo=github)](https://github.com/brocolidata/dataplatform_lab/generate) to create a repository from this template
2. Clone it and open in Visual Studio Code
3. When this popup appears, click on **Reopen in Container** 
   
   <img src="https://code.visualstudio.com/assets/docs/devcontainers/create-dev-container/dev-container-reopen-prompt.png" height=80, width=300 style="display: block; left-margin: 50" />

   *If the popup does not appear, look for this button on the bottom left corner (green button on the image) and select **Reopen in Container***

   <img src="https://code.visualstudio.com/assets/docs/devcontainers/containers/remote-dev-status-bar.png" height=60, width=150 style="display: block; left-margin: 50" />


### GitHub Codespace
Click on this badge [![Open in Codespace](https://img.shields.io/static/v1?label=Codespace&message=Open&color=blue&logo=github)](https://github.com/codespaces/new?template_repository=brocolidata/dataplatform_lab) and wait while Docker is pulling the image, building the dev container and installing VSCode extensions. 


## Prerequisites for local development
- Docker (started) and Docker Compose (just install [Docker Desktop](https://www.docker.com/products/docker-desktop/) if you are on laptop).
- [Visual Studio Code](https://code.visualstudio.com/) + the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.
