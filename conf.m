%% Configuration file for the building input/output targets

% Where the project stores main.m script
PROJECT_DIR = pwd;

% Where main.m could find the data to be analyzed
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

% Set the name of the directory that will store figures
FIGURES_OUTPUT_DIR = 'figures';

% Set this to 1 to save figures to the output directory also
STORE_FIGURES = 0;

% Path where the program will store figures
FIG_PATH = 'output/figures';

% Categories to take in account for classification
CATEGORIES = {'supine' 'dorsiflexion' 'walking' 'stairs'};

% Sensors' sampling time
SAMPLING_TIME = 0.082;
