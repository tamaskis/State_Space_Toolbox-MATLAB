%==========================================================================
%
% f2F_sym  Discrete dynamics Jacobian from continuous dynamics equation
% (1st-order approximation).
%
%   F = f2F_sym(f,x)
%   F = f2F_sym(f,x,xe)
%   F = f2F_sym(f,x,xe,u,ue)
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
%   f       - (n×1 sym) continuous dynamics equation
%   x       - (n×1 sym) state vector
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%   u       - (m×1 sym) (OPTIONAL) control input
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   F       - (n×n sym) discrete dynamics Jacobian at kth sample
%
%==========================================================================
function F = f2F_sym(f,x,xe,u,ue)
    
    % defaults xe to empty vector
    if (nargin < 3)
        xe = [];
    end
    
    % defaults u to empty vector
    if (nargin < 4)
        u = [];
    end
    
    % defaults ue to empty vector
    if (nargin < 5)
        ue = [];
    end
    
    % continuous time variable
    syms t;
    
    % discrete dynamics equation from continuous dynamics equation
    [fd,xk,uk] = f2fd_sym(f,x,u,t);
    
    % discrete dynamics Jacobian from discrete dynamics equation
    F = fd2F_sym(fd,xk,xe,uk,ue);
    
end