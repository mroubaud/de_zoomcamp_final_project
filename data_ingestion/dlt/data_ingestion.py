import dlt
import duckdb

import json
import requests
import parquet
import pandas as pd
import numpy as np

import os
import glob
from gcloud import storage
from oauth2client.service_account import ServiceAccountCredentials
        
import urllib3, socket
from urllib3.connection import HTTPConnection


#API authorization and ifno
api_token_wc = "***"
my_headers = {"Authorization" : f"Bearer {api_token_wc}"}
api_url = "https://staging.data-api.bepro11.com"

HTTPConnection.default_socket_options = (HTTPConnection.default_socket_options + [(socket.SOL_SOCKET, socket.SO_SNDBUF, 1000000), #1MB in byte 
                                        (socket.SOL_SOCKET, socket.SO_RCVBUF, 1000000)])

# GCS Credentials: Only need this if you're running this code locally.
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '../../keys/credentials.json'
os.environ['GOOGLE_CLOUD_PROJECT'] = '***'

def get_match_event_data_paggineted(match_id):
 
    limit = 100
    page_number = 1

    while True:   
        offset = (page_number-1)*limit
        # API request
        response = requests.get(f"{api_url}/api/matches/{match_id}/event_data?limit={limit}&offset={offset}", headers=my_headers)
        
        # Raise an HTTPError for bad responses
        response.raise_for_status()  
        
        # Get response
        page_json = response.json()
        
        if page_json:
            if (page_json["result"] != []):
                yield page_json["result"]
                page_number += 1
            else:
                break
            
        else:
            # No more data, break the loop
            break

#API request Leagues Info
response = requests.get(f"{api_url}/api/leagues", headers=my_headers)
#Raise an HTTPError for bad responses
response.raise_for_status()  
#Get response
page_json = response.json()
#print(page_json["result"][0])
#save league and season info of the tournament
league_id = page_json["result"][0]["id"]
season_ids = page_json["result"][0]["season_ids"]
season_id = season_ids[0]


#API request teams info
response = requests.get(f"{api_url}/api/teams?season={season_id}", headers=my_headers) 
# Raise an HTTPError for bad responses
response.raise_for_status()      
# Get response
page_json = response.json()
# Get teams
teams_list = page_json["result"]
#print(teams_list)
#define the pipeline
pipeline_teams = dlt.pipeline(
    pipeline_name='teams_pipeline',
    destination='bigquery',
    dataset_name='match_events_dataset',
    import_schema_path="schemas/import",
    export_schema_path="schemas/export"
)
#run teams pipeline and save in teams table
load_teams_info = pipeline_teams.run(teams_list, write_disposition="append", table_name="teams_table")
#define the pipeline
pipeline_players = dlt.pipeline(
    pipeline_name='players_pipeline',
    destination='bigquery',
    dataset_name='match_events_dataset',
    import_schema_path="schemas/import",
    export_schema_path="schemas/export"
)
for team in teams_list:
    ###API request player 
    team_id = team["id"]
    response = requests.get(f"{api_url}/api/players?team={team_id}", headers=my_headers)
    # Raise an HTTPError for bad responses
    response.raise_for_status()  
    # Get response
    page_json = response.json()
    # Get teams
    players_list = page_json["result"]
    #display(players_list)
    #For the players of each team, run the pipeline and save the info in players table
    load_players_info = pipeline_players.run(players_list, write_disposition="append", table_name="players_table")

#API request matches info
response = requests.get(f"{api_url}/api/matches?season={season_id}", headers=my_headers)
# Raise an HTTPError for bad responses
response.raise_for_status()  
# Get response
page_json = response.json()
# Get matches
matches = page_json["result"]
#print(matches)

#define the pipeline for get match information
pipeline_match_info = dlt.pipeline(
    pipeline_name='match_info_pipeline',
    destination='bigquery',
    dataset_name='match_events_dataset',
    import_schema_path="schemas/import",
    export_schema_path="schemas/export"
)
#run match_info pipeline and save in match_info table
load_match_info = pipeline_match_info.run(matches, write_disposition="append", table_name="match_info_table")

#define the pipeline for get match events
pipeline_match_events = dlt.pipeline(
    pipeline_name='match_events_pipeline',
    destination='bigquery',
    dataset_name='match_events_dataset',
    import_schema_path="schemas/import",
    export_schema_path="schemas/export"
)
#define the team stats pipeline
pipeline_team_stats_match = dlt.pipeline(
    pipeline_name='pipeline_match_team_stats',
    destination='bigquery',
    dataset_name='match_team_stats_dataset',
    import_schema_path="schemas/import",
    export_schema_path="schemas/export"
)
#define the players stats pipeline
pipeline_match_players_stats = dlt.pipeline(
    pipeline_name='pipeline_match_players_stats',
    destination='bigquery',
    dataset_name='match_players_stats_dataset',
    import_schema_path="schemas/import",
    export_schema_path="schemas/export"
)

#define the players stats pipeline
pipeline_match_sequence = dlt.pipeline(
    pipeline_name='pipeline_match_sequence',
    destination='bigquery',
    dataset_name='match_sequence_dataset',
    import_schema_path="schemas/import",
    export_schema_path="schemas/export"
)

#for each match, run the pipeline and save info in matches table, player stats table and team stats table
for match_info in matches:
    match_id = match_info["id"]
    print(match_id)
    load_match_events_info = pipeline_match_events.run(get_match_event_data_paggineted(match_id), write_disposition="append", table_name="match_events_table")
    match_id = match_info["id"]
    response_players_stats = requests.get(f"{api_url}/api/matches/{match_id}/player_stats", headers=my_headers)
    response_players_stats.raise_for_status()  
    response_players_stats_json = response_players_stats.json()
    load_match_players_stats_info = pipeline_match_players_stats.run(response_players_stats_json["result"], write_disposition="append", table_name="match_players_stats_table")
    for player in response_players_stats_json['result']:
        player["match_id"] = match_id
    load_match_info = pipeline_match_info.run(matches, write_disposition="append", table_name="match_info_table")
    response_team_stats = requests.get(f"{api_url}/api/matches/{match_id}/team_stats", headers=my_headers)
    # Raise an HTTPError for bad responses
    response_team_stats.raise_for_status()  
    # Get response
    response_team_stats_json = response_team_stats.json()
    response_team_stats_json['result'][0]['match_id'] = match_id
    response_team_stats_json['result'][1]['match_id'] = match_id
    load_match_team_stats_info = pipeline_team_stats_match.run(response_team_stats_json["result"], write_disposition="append", table_name="match_team_stats_table")
    response_match_sequence = requests.get(f"{api_url}/api/matches/{match_id}/sequence_data", headers=my_headers)
    # Raise an HTTPError for bad responses
    response_match_sequence.raise_for_status()  

    # Get response
    response_match_sequence_json = response_match_sequence.json()
    for sequence in response_match_sequence_json['result']:
        sequence["match_id"] = match_id
    load_match_sequence_info = pipeline_match_sequence.run(response_match_sequence_json['result'], write_disposition="append", table_name="match_sequence_table")