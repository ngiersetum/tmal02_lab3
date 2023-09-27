function [skin, form, misc, induced] = dragFunction(altitude, velocities)
% Calculate different drag contributions for one given altitude over one or
% several velocities
% 
% Inputs
%   aircraft (string)               - key in the aircraft database
%   altitude (scalar)               - flight altitude [m]
%   velocities (scalar or vector)   - flight velocities [m/s]
% 
% License
%   This program is part of an academic exercise for the course TMAL02,
%   Linköping University, year 2023. The program is therefore free for 
%   non-commercial academic use.
%
% Code History
%   https://github.com/ngiersetum/tmal02_lab3

%% Technical data A340-300
l = 63.60; % length in [m]
s = 60.3; % spanwidth in [m]
h = 16.80; % height in [m]
s_wing = 363.1; % wing reference are in [m^2]
AR = 10;
sweep_angle = 29.7; %[°]
l_fuse = 5.64; % fuselage outside width in [m]



%% Technical data CFM International CFM56-5C
l_eng = 2.622; % [m]
w_eng = 1.908; % [m]
h_eng = 2.25; % [m]
d_fan = 1.84; % [m]
%Takeoff thrust of one engine = 138.78–151.24 kN

    
    %% Parameters for induced drag

    e = 0.776;   % Oswald Efficiency Number

    [T, P, rho, a, mu] = ISAfunction(altitude);     % atmospheric conditions

    for i=1:numel(velocities)

        vel = velocities(i);
        mach = vel/a;
        nu = mu/rho;

        %% PARASITIC DRAG (Component build-up method)

        % Skin Friction Drag
        skin(i) = 0;

        % Form Drag
        form(i) = 0;

        % Interference Drag


        % Miscellaneous Drag
        misc(i) = 0;

        %% LIFT-INDUCED DRAG

        weight = 230000; % [kg], average of MTOW and MLW
        lift = weight * 9.80665; % lift is equal to weight in cruise (L = mg)
        cl = sref;

        cdi = cl^2 / e*pi*ar

        induced(i) = 0;
    end
end