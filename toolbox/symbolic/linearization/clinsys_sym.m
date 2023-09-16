%==========================================================================
%
% clinsys_sym  Linearize a continuous-time state space system.
%
%   [A,B,C,D] = clinsys_sym(f,h,x,u)
%   [A,B,C,D] = clinsys_sym(f,h,x,u,xe,ue)
%
% See also TODO.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-05-22
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/State_Space_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (n×1 sym) continuous dynamics equation
%   h       - (p×1 sym) continuous measurement equation
%   x       - (n×1 sym) state vector
%   u       - (m×1 sym) control input
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   A       - (n×n sym) continuous dynamics Jacobian
%   B       - (n×m sym) continuous input Jacobian
%   C       - (p×n sym) continuous measurement Jacobian
%   D       - (p×m sym) continuous feedforward Jacobian
%
%==========================================================================
function [A,B,C,D] = clinsys_sym(f,h,x,u,xe,ue)
    
    % defaults equilibrium state vector to empty vector if not specified
    if (nargin < 5) || isempty(xe)
        xe = [];
    end
    
    % defaults equilibrium control input to empty vector if not specified
    if (nargin < 6) || isempty(ue)
        ue = [];
    end
    
    % performs linearizations
    A = f2A_sym(f,x,xe,u,ue);
    B = f2B_sym(f,u,ue,x,xe);
    C = h2C_sym(h,x,xe,u,ue);
    D = h2D_sym(h,u,ue,x,xe);
    
end