# DATA ENGINEER ZOOMCAMP PROJECT

## WORLD CUP QATAR 2022 POWERED BY BEPRO

### Problem Description

In professional football, the data is playing an important rol these days. Have the chance to get insights and meaningful information from our players and team can make the difference between winning and loosing.
In this project, we gonna analyse the data of the World Cup of Qatar 2022. All the data used in this project is provided be Bepro through its API.
Our main goal is to analyse the data and try to find valuable information about the teams and or players that participate in the tournament, in order to arrive to usefull conclusions.

<p align="center">
  <img align="center" width="166"  alt="bepro_icon" src="https://github.com/mroubaud/de_zoomcamp_project/assets/91369962/8d0fd9dc-aad1-4112-a4f5-328648503df3">
  <img align="center" width="166"  alt="world_cup_catar_2022_icon" src="https://github.com/mroubaud/de_zoomcamp_project/assets/91369962/1e8cbacb-a8c6-4e37-a9c0-0c11d26046f2">
</p>

### Project Architecture

For this project, the following architecture diagram was used:

<p align="center">
  <img width="1000" alt="image" src="https://github.com/mroubaud/de_zoomcamp_project/assets/91369962/e7ab4abd-e253-4534-9170-3d07232046a5">
</p>

Each part ot the architecture diagram will be explained in this document.

### Bepro API

Bepro analyzed all the matches of the world cup of Qatar 2022 and it provides all the data through its API. We can obtain all the _eventing_ information about a match with a simple request to the Bepro API. Same apply for information about team and players, betweend others. The response of all the request done to Bepro API are in JSON format. See section **Resources** for more information about Bepro and Bepro API.

### Data Ingestion: Batch Processing with dlt

Data Ingestion process was made through a python script called _data_ingestion.py_ inside the _data_ingestion_ folder.This script use _dlt_ to convert the response of the Bepro API from JSON to tabular format. Tables are store in Google Big Query in SQL format. Another advantage to use dlt is that it use the concept of _generator_, which allows to process the data in a more efficient way (_"line by line"_), without the need to use a lot of memory resources.

### Data warehouse: Google Big Query

The data is stored in Google Big Query in the form of SQL tables.

### Data Transformations: dbt

In order to clean and transform the data and also create new metrics, dbt was used. All the _dbt_ files used in the project are included in the folder called _data_transformation_. The main advantage of using _dbt_ are:

- Easy integration with Google Big Query and Github using best programming practice (CI-CD).
- Can perform test in our data to check that everything it's ok before uploading it to the storage.
- Its provide a function to create documentation for the proyect in an easy way.

### Dashboards: Tableau

To create Dashboards, _Tableau_ was the chosen tool. _Tableau_ integrates easily and automatically with Google Big Query and allows the creator to public the dashboards in _Tableau Public_, which is an online free tool of _Tableau_. Anyone can access to this dashboard for free. Links of the created Dashboards: 
  - [Argentina](https://public.tableau.com/app/profile/matias.gonzalo.roubaud.lazo/viz/de_zoomcamp_final_project/Argentina).
  - [France](https://public.tableau.com/app/profile/matias.gonzalo.roubaud.lazo/viz/de_zoomcamp_final_project_france/France?publish=yes).
  - [Croatia](https://public.tableau.com/app/profile/matias.gonzalo.roubaud.lazo/viz/de_zoomcamp_final_project_croatia/Croatia?publish=yes).
  - [Morocco](https://public.tableau.com/app/profile/matias.gonzalo.roubaud.lazo/viz/de_zoomcamp_final_project_morocco/Morocco?publish=yes).
  - [Top 4 Comparation](https://public.tableau.com/app/profile/matias.gonzalo.roubaud.lazo/viz/de_zoomcamp_final_project_top4_comparation/Teamcomparation?publish=yes).
### Resources

- About [Bepro](https://space.bepro11.com/)
- [Bepro API documentation](https://bepro.notion.site/Bepro-Data-API-Guidebook-32f413691e8546f587a98c59d8b426e3])
- [Bepro API request-response structure](https://staging.data-api.bepro11.com/schema/redoc/)
- [Bepro Event Definition](https://www.notion.so/bepro/Bepro-Event-Definitions-Archived-4eea4fc9538e485ca02842e88f81072c)
- About [dlt](https://dlthub.com/docs/intro)
- About [Google Big Query](https://cloud.google.com/bigquery/docs)
- About [dbt](https://docs.getdbt.com/docs/introduction)
- About [Tableau](https://www.tableau.com/)
