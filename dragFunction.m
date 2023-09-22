function [skin, form, misc, induced] = dragFunction(aircraft, altitude, velocities)
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

        % Miscellaneous Drag
        misc(i) = 0;

        %% LIFT-INDUCED DRAG

        induced(i) = 0;
    end
end