%==========================================================================
%
% h2J_sym  Discrete feedforward Jacobian from continuous measurement
% equation.
%
%   J = h2J_sym(h,x,u)
%   J = h2J_sym(h,x,u,xe,ue)
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
%   u       - (m×1 sym) control input
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   J       - (p×m sym) discrete feedforward Jacobian at kth sample
%
%==========================================================================
function J = h2J_sym(h,x,u,xe,ue)
    
    % defaults xe to empty vector
    if (nargin < 4)
        xe = [];
    end
    
    % defaults ue to empty vector
    if (nargin < 5)
        ue = [];
    end
    
    % continuous time variable
    syms t;
    
    % discrete measurement equation from continuous measurement equation
    [hd,xk,uk] = h2hd_sym(h,x,u,t);
    
    % discrete feedforward Jacobian from discrete measurement equation
    J = hd2J_sym(hd,uk,ue,xk,xe);
    
end