%% example_define_dynamics.m
% State Space Toolbox
%
% Example of defining a continuous-time, nonlinear dynamics equation.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-05-03
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;



%% SOLUTION

% parameters
b = 5;          % damping constant [N.s/m]
k = 1;          % spring constant [N/m]
m = 2;          % mass [kg]
x0 = 1;         % initial position [m]
dx0 = 0;        % initial velocity [m/s]

% initial condition
x0 = [x0;
      dx0];

% differential equation
f = @(x,u,t) [ x(2);
              -(b/m)*x(2)-(k/m)*x(1)+(1/m)*u];



%% ALTERNATE SOLUTION

% parameters
b = 5;          % damping constant [N.s/m]
k = 1;          % spring constant [N/m]
m = 2;          % mass [kg]
x0 = 1;         % initial position [m]
dx0 = 0;        % initial velocity [m/s]

% initial condition
x0 = [x0;
      dx0];

% assigns function handle to differential equation
f = @(x,u,t) f_extra(x,u,b,k,m);

% defines dynamics equation
function dxdt = f_extra(x,u,b,k,m)
    
    % unpacks state vector
    %   --> Note that we unpack the position, "x", last. This is because 
    %       the state vector is also input as "x", so when we write 
    %       "x = x(1)", we essentially get rid of the original state 
    %       vector. However, we have to extract all the other state
    %       variables from the state vector first before we get rid of it.
    xdot = x(2);
    x = x(1);
    
    % unpacks control input
    F = u;
    
    % assembles state vector derivative
    dxdt = [ xdot;
            -(b/m)*xdot-(k/m)*x+(1/m)*F];
    
end