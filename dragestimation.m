% LAB 3: Drag Estimation (A340-300)
%   Calculations of different statistical correlations from an external
%   data set on different aircraft types.
%
%   Code should be run in isolated sections to obtain certain plots,
%   otherwise they will overwrite each other. As long as the first section
%   is run once to load in the data, every section can run in any order.
%
% References
%   Lab Data Set
%
% Authors
    liuID1 = "nikgi434"; % Niklas Gierse
    liuID2 = "leomu719"; % Leonhard Muehlstrasser
%
% License
%   This program is part of an academic exercise for the course TMAL02,
%   Linköping University, year 2023. The program is therefore free for 
%   non-commercial academic use.
%
% Code History
%   https://github.com/ngiersetum/tmal02_lab3
%
%% Executable Section

load('data/actable.mat')

% a343data = acdata{"A340-300",:};