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