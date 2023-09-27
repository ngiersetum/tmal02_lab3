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
l = acdata("A340-300", "Fuse_Length"); % length in [m]
l_cockpit = 6; % [m]
l_empennage = 12; % [m]
s = 60.3; % spanwidth in [m]
h = 16.80; % height in [m]
s_wing = 363.1; % wing reference are in [m^2]
AR = 10;
sweep_angle = 29.7; %[°]
r_fuse = acdata("A340-300", "Fuse_Width") * 0.5; % fuselage outside width in [m]
slant_height_cockpit = sqrt(r_fuse^2 + l_cockpit^2);
slant_height_empennage = sqrt(r_fuse^2 + l_empennage^2);

s_wet_wing = 2.25 * s_wing;
s_wet_fuse = (2*pi*l*r_fuse + 2*pi*r_fuse^2) + (pi*r_fuse^2 + pi * r_fuse * slant_height_cockpit) + (pi*r_fuse^2 + pi * r_fuse * slant_height_empennage);
s_wet_nacelle = 4 * ((2*pi*(acdata("A340-300", "NacelleWidth")/2)^2) + (2*pi*acdata("A340-300", "NacelleWidth")*0.5*acdata("A340-300", "NacelleLength")));
s_wet_empennage = 2.25 * acdata("A340-300", "TailVertArea") + 2.25 * acdata("A340-300", "TailHorArea");


    
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