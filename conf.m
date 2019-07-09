%% Configuration file for the building input/output targets

% Where the project stores main.m script
PROJECT_DIR = pwd;

% Where main.m could find the data to be analized
DATA_DIRS = { 'Measurements_10_volunteers/Volunteer 1';
    'Measurements_10_volunteers/Volunteer 2';
    'Measurements_10_volunteers/Volunteer 3';
    'Measurements_10_volunteers/Volunteer 4';
    'Measurements_10_volunteers/Volunteer 5';
    'Measurements_10_volunteers/Volunteer 6';
    'Measurements_10_volunteers/Volunteer 7';
    'Measurements_10_volunteers/Volunteer 8';
    'Measurements_10_volunteers/Volunteer 9';
    'Measurements_10_volunteers/Volunteer 10'
};

% Which file names the program should load from DATA_DIRS. Only * wildcard character is supported.
% main.m can load only xlsx files
FILE_PATTERN = {'*supine.xlsx';
             '*dorsiflexion.xlsx';
             '*walking.xlsx';
             '*stairs.xlsx';
};

% The name of the file where main.m stores data from files in order to avoid loading data from files
% each time main.m is run
DB_FILE_NAME = 'db.mat';

% Where the program has to write each output file
OUTPUT_DIR = 'output';

% The number of sensor we consider in the xlsx files
SENSOR_NUM = 3;

% Set to 1 if you want to load raw data from files each time you run main.m
% instead of loading them from the DB
DELETE_DATA = 1;

% Set to 1 if you want to have all data structure this program uses in
% order to debug things
DEBUG = 1;

% Categories to take in account for classification
CATEGORIES = {'supine' 'dorsiflexion' 'walking' 'stairs'};

% Sensors' sampling time
SAMPLING_TIME = 0.082;

% Length of the chunks to be analyzed. The program will analyze each chunk
% length and will produce a neuronal network for each chunk. It is in the
% matlab format to define intervals: start:increment:end
% For example 12:12:360 means [12 24 36 ... 360], that is an array of 30
% values from 12 to 360     
CHUNKS_TO_ANALYZE = 12:12:360;
