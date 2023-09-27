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

% FLIGHT CONDITION
altitude = 9000;                % [m]

[T, P, rho, a, mu] = ISAfunction(altitude);

vApp_ms = acdata{"A340-300", "Speed_Vapp"} * 1.852 / 3.6;
vNe_ms = acdata{"A340-300", "Speed_Mne"} * a;

vMin = floor(vApp_ms/10)*10;
vMax = ceil(vNe_ms/10)*10;

velocities = vMin:5:vMax;      % [m/s]

% Calculate drag across the range of velocities
[parasitic, induced] = dragFunction(altitude, velocities);

machs = velocities / a;

%% Thrust calculations

staticthrust = table2array(acdata("A340-300","EngStaticThrustkN")) * 4000; % *1000 for kN -> N
rho0 = 1.2250;

thrust = staticthrust * (rho / rho0) * (1 - 0.25*machs);

thrust = thrust * table2array(acdata("A340-300","EngNumbersOf"));

%% Plot results
hold on
grid on

plot(machs, parasitic, 'g');
plot(machs, induced, 'b');
plot(machs, parasitic + induced, 'r', 'LineWidth', 1);
plot(machs, thrust, 'k', 'LineWidth', 1);

legend('Parasitic Drag', 'Induced Drag', 'Total Drag', 'Thrust')

xlabel('Flight Velocity [Mach]')
ylabel('Thrust, Drag [N]')
title('A340-300: Drag at different velocities at 9000m')

