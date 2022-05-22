%==========================================================================
%
% h2H_sym  Discrete measurement Jacobian from continuous measurement
% equation.
%
%   H = h2H_sym(h,x)
%   H = h2H_sym(h,x,xe)
%   H = h2H_sym(h,x,xe,u,ue)
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
% https://tamaskis.github.io/documentation/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   h       - (p×1 sym) continuous measurement equation
%   x       - (n×1 sym) state vector
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector
%   u       - (m×1 sym) (OPTIONAL) control input
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input
%
% -------
% OUTPUT:
% -------
%   H       - (p×n sym) discrete measurement Jacobian at kth sample
%
%==========================================================================
function H = h2H_sym(h,x,xe,u,ue)
    
    % defaults xe to empty vector if not input
    if (nargin < 3)
        xe = [];
    end
    
    % defaults u to empty vector if not input
    if (nargin < 4)
        u = [];
    end
    
    % defaults ue to empty vector if not input
    if (nargin < 5)
        ue = [];
    end
    
    % continuous time variable
    syms t;
    
    % discrete measurement equation from continuous measurement equation
    [hd,xk,uk] = h2hd_sym(h,x,u,t);
    
    % discrete measurement Jacobian from discrete measurement equation
    H = hd2H_sym(hd,xk,xe,uk,ue);
    
end