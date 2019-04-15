function configuration = load_conf(conf_path)
%LOAD_CONF Load configuration variables into a struct
%   It takes the configuration path, read all the variables and put them
%   inside a struct, so the user can call configuration.CONF_PARAMETER to
%   have a single place where all the configuration parameters are stored.
run(conf_path);

configuration.PROJECT_DIR = PROJECT_DIR;
configuration.DATA_DIRS = DATA_DIRS;
configuration.FILE_PATTERN = FILE_PATTERN;
configuration.DB_FILE_NAME = DB_FILE_NAME;
configuration.OUTPUT_DIR = OUTPUT_DIR;
configuration.SENSOR_NUM = SENSOR_NUM;
configuration.DELETE_DATA = DELETE_DATA;
configuration.FIGURES_OUTPUT_DIR = FIGURES_OUTPUT_DIR;
configuration.STORE_FIGURES = STORE_FIGURES;
configuration.FIG_PATH = FIG_PATH;
configuration.CATEGORIES = CATEGORIES;
configuration.SAMPLING_TIME = SAMPLING_TIME;
end

