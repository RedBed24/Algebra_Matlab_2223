% Incremental practice for Algebra & Discrete Mathematics
% 2022-23
% 
% Name of the student: 
% Milestone 1
% Briefly describe the steps taken to address this milestone:
% 
% 
% 
% 

clear all
clc;


%% Variable definition
data_dir = '../Data/'; % Relative path to the data


%% Load graph data

% Example of how to load a CSV in MATLAB
% Use the MATLAB documentation to check how the following code works
% This is just an example, please, remove it before you start
opts = detectImportOptions(strcat(data_dir,'example_data.csv'));
opts = setvartype(opts, {'column_1','column_2','column_3'}, {'int64','string','string'});
example_data = readtable(strcat(data_dir,'example_data.csv'), opts);

% Modify this section with the corresponding code...


%% Construct the graph

% Complete with the corresponding code...
