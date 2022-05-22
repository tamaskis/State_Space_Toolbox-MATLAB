%% example_inverted_pendulum.m
% State Space Toolbox
%
% Inverted pendulum example (Appendix B of "State Space Systems: 
% Linearization, Discretization, and Simulation").
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-05-21
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;



%% SYSTEM PARAMETERS

l = 1;      % pendulum length [m]
m = 1;      % pendulum mass [kg]
M = 10;     % cart mass [kg]
g = 10;     % gravitational acceleration [m/s²]



%% CONTINUOUS-TIME NONLINEAR SYSTEM

% continuous-time nonlinear dynamics equation (see "dynamics" function at
% the bottom of this script)
f = @(x,u,t) dynamics(x,u,M,m,l,g);

% continuous-time nonlinear measurement equation
h = @(x,u,t) x(3);

% initial guess for equilibrium point
x0 = zeros(4,1);
u0 = 0;

% equilibrium point
[xe,ue] = find_equil_num(f,x0,u0);



%% CONTINUOUS-TIME LINEARIZED SYSTEM

% we can linearize the system all at once using the clinsys_lti function
[A,B,C,D] = clinsys_lti(f,h,xe,ue);

% alternatively, we could have done the following:
%   A = f2A_lti(f,xe,ue)
%   B = f2B_lti(f,xe,ue)
%   C = h2C_lti(h,xe,ue)
%   C = h2D_lti(h,xe,ue)



%% FUNCTIONS

%==========================================================================
% dynamics  Dynamics of an inverted pendulum on a cart.
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   x       - (4×1 double) state vector
%               --> 1. x        - cart position [m]
%               --> 2. xdot     - cart velocity [m/s]
%               --> 3. theta    - pendulum angle [rad]
%               --> 4. thetadot - pendulum angular velocity [rad/s]
%   u       - (1×1 double) control input
%               --> 1. F - force on cart [N]
%   M       - (1×1 double) cart mass [kg]
%   m       - (1×1 double) pendulum mass [kg]
%   l       - (1×1 double) pendulum length [m]
%   g       - (1×1 double) gravitational acceleration [m/s²]
%
% -------
% OUTPUT:
% -------
%   dxdt    - (4×1 double) state vector derivative
%
%==========================================================================
function dxdt = dynamics(x,u,M,m,l,g)
    
    % unpacks state vector
    %   --> Note that we unpack the position, "x", last, since this
    %       essentially gets rid of the state vector, also input as "x",
    %       which we also need to exract other state variables from.
    xdot = x(2);
    theta = x(3);
    thetadot = x(4);
    x = x(1);
    
    % unpoacks control input
    F = u;
    
    % dynamics of cart
    xddot = (m*(g*cos(theta)-l*thetadot^2)*sin(theta)+F)/(M+m*...
        sin(theta)^2);
    
    % dynamics of inverted pendulum
    thetaddot = (cos(theta)/l)*((m*(g*cos(theta)-l*thetadot^2)*...
        sin(theta)+F)/(M+m*sin(theta)^2))+(g*sin(theta)/l);
    
    % assembles state vector derivative
    dxdt = [xdot;
            xddot;
            thetadot;
            thetaddot];
    
end