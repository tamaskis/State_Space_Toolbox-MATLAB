%==========================================================================
%
% f2G_sym  Discrete input Jacobian from continuous dynamics equation 
% (1st-order approximation).
%
%   G = f2G_sym(f,x,u)
%   G = f2G_sym(f,x,u,xe,ue)
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
%   x       - (n×1 sym) state vector
%   u       - (m×1 sym) control input
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   G       - (n×m sym) discrete input Jacobian at kth sample
%
%==========================================================================
function G = f2G_sym(f,x,u,xe,ue)
    
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
    
    % discrete dynamics equation from continuous dynamics equation
    [fd,xk,uk] = f2fd_sym(f,x,u,t);
    
    % discrete input Jacobian from discrete dynamics equation
    G = fd2G_sym(fd,uk,ue,xk,xe);
    
end