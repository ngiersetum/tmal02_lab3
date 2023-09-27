function [parasitic, induced] = dragFunction(altitude, velocities)
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

load('data/actable.mat')

%% Technical data A340-300
l = table2array(acdata("A340-300", "Fuse_Length")); % length in [m]
l_cockpit = 6; % [m]
l_empennage = 12; % [m]
s = 60.3; % spanwidth in [m]
h = 16.80; % height in [m]
s_wing = 363.1; % wing reference are in [m^2]
AR = table2array(acdata("A340-300", "AspectRatio"));
sweep_angle = 29.7; %[°]
r_fuse = table2array(acdata("A340-300", "Fuse_Width"))/2; % fuselage outside width in [m]
slant_height_cockpit = sqrt(r_fuse^2 + l_cockpit^2);
slant_height_empennage = sqrt(r_fuse^2 + l_empennage^2);

s_wet_wing = 2.25 * s_wing;
s_wet_fuse = (2*pi*l*r_fuse + 2 * pi*r_fuse^2) + (pi*r_fuse^2 + pi * r_fuse * slant_height_cockpit) + (pi*r_fuse^2 + pi * r_fuse * slant_height_empennage);
s_wet_nacelle = 4 * ((2*pi*(table2array(acdata("A340-300", "NacelleWidth"))/2)^2) + (2*pi*table2array(acdata("A340-300", "NacelleWidth")) * 0.5 * table2array(acdata("A340-300", "NacelleLength"))));
s_wet_empennage = 2.25 * table2array(acdata("A340-300", "TailVertArea")) + 2.25 * table2array(acdata("A340-300", "TailHorArea"));


    
    %% Parameters for induced drag

    e = 0.776;   % Oswald Efficiency Number

    [T, P, rho, a, mu] = ISAfunction(altitude);     % atmospheric conditions

    for i=1:numel(velocities)

        vel = velocities(i);
        mach = vel/a;
        nu = mu/rho;
        dynPress = 0.5 * rho * vel*vel;
        Re_pre = 1/nu * vel;
        
        %% PARASITIC DRAG (Component build-up method)

        % characteristic lengths
        lchar_fuse = l;
        lchar_wing = table2array(acdata("A340-300", "MAC"));
        lchar_tvert = ;
        lchar_thor = 
        lchar_nacelle = table2array(acdata("A340-300", "NacelleLength")); 

        % chordwise location of maximum thickness point
        xc_wing = 0;
        xc_tvert = 0;
        xc_thor = 0;

        %thickness to chord
        tc_wing = 0;
        tc_tvert = 0;
        tc_thor = 0;

        % sweep angle at maximum thickness line
        phi_wing = 0;
        phi_tvert = 0;
        phi_thor = 0;

        % slenderness ratios
        f_fuse = lchar_fuse/table2array(acdata("A340-300", "Fuse_Width"));
        f_nacelle = lchar_nacelle/table2array(acdata("A340-300", "NacelleWidth"));
        
        % Skin Friction Drag
        % Fuselage
        Csd_fuse = 0.455 / ((log10(Re_pre * lchar_fuse))^2.58 *(1 + 0.144 * mach^2)^0.65);
        Csd_wing = 0.455 / ((log10(Re_pre * lchar_wing))^2.58 *(1 + 0.144 * mach^2)^0.65);
        Csd_tvert = 0.455 / ((log10(Re_pre * lchar_tvert))^2.58 *(1 + 0.144 * mach^2)^0.65);
        Csd_thor = 0.455 / ((log10(Re_pre * lchar_thor))^2.58 *(1 + 0.144 * mach^2)^0.65);
        Csd_nacelle = 0.455 / ((log10(Re_pre * lchar_nacelle))^2.58 *(1 + 0.144 * mach^2)^0.65);

        % Form Drag
        FF_fuse = (1 + 5/(f_fuse^1.5) + f_fuse/400);
        FF_wing = (1 + 0.6/xc_wing * tc_wing + 100* tc_wing^4) * (1.34 * mach^0.18 * cos(phi_wing)^0.28);
        FF_tvert = (1 + 0.6/xc_tvert * tc_tvert + 100* tc_tvert^4) * (1.34 * mach^0.18 * cos(phi_tvert)^0.28);
        FF_thor = (1 + 0.6/xc_thor * tc_thor + 100* tc_thor^4) * (1.34 * mach^0.18 * cos(phi_thor)^0.28);
        FF_nacelle = 1 + 0.35 / f_nacelle;
        form(i) = 0;

        % Interference Drag


        % Miscellaneous Drag
        misc(i) = 0;

        %% LIFT-INDUCED DRAG

        weight = 230000; % [kg], average of MTOW and MLW
        lift = weight * 9.80665; % lift is equal to weight in cruise (L = mg)

        cl = lift / (s_wing * dynPress);

        cdi = (cl*cl) / (e*pi*AR);

        induced(i) = dynPress * s_wing * cdi;
    end
end