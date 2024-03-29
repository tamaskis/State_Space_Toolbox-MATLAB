%==========================================================================
%
% f2fd_sym  Discrete dynamics equation from continuous dynamics equation
% (1st-order approximation).
%
%   fd = f2fd_sym(f,x)
%   fd = f2fd_sym(f,x,u)
%   fd = f2fd_sym(f,x,[],t)
%   fd = f2fd_sym(f,x,u,t)
%   [fd,xk,uk] = f2fd_sym(__)
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
%   u       - (m×1 sym) (OPTIONAL) control input
%   t       - (1×1 sym) (OPTIONAL) time
%
% -------
% OUTPUT:
% -------
%   fd      - (n×1 sym) discrete dynamics equation
%   xk      - (n×1 sym) state vector at kth sample, xₖ
%   uk      - (m×1 sym) control input at kth sample, uₖ
%
% -----
% NOTE:
% -----
%   --> "u" and "t" must be input if you want them to be subscripted with
%       "k".
%
%==========================================================================
function [fd,xk,uk] = f2fd_sym(f,x,u,t)
    
    % time step
    syms Delta_t;
    
    % state vector at kth sample time
    xk = subscript_k(x);
    
    % control input at kth sample time (empty vector if "u" not input)
    if (nargin >= 3) && ~isempty(u)
        uk = subscript_k(u);
    else
        u = [];
        uk = [];
    end
    
    % kth sample time (empty vector if "t" not input)
    if (nargin == 4) && ~isempty(t)
        tk = subscript_k(t);
    else
        t = [];
        tk = [];
    end
    
    % evaluation of continuous dynamics equation at kth sample time
    fk = subs(f,[x;u;t],[xk;uk;tk]);
    
    % discretization
    fd = simplify(xk+fk*Delta_t,'Steps',20);
    
end