%==========================================================================
%
% h2hd_sym  Discrete measurement equation from continuous measurement
% equation.
%
%   hd = h2hd_sym(h,x)
%   hd = h2hd_sym(h,x,u)
%   hd = h2hd_sym(h,x,[],t)
%   hd = h2hd_sym(h,x,u,t)
%   [hd,xk,uk] = h2hd_sym(__)
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
%   u       - (m×1 sym) (OPTIONAL) control input
%   t       - (1×1 sym) (OPTIONAL) time
%
% -------
% OUTPUT:
% -------
%   hd      - (p×1 sym) discrete measurement equation
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
function [hd,xk,uk] = h2hd_sym(h,x,u,t)
    
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
    
    % discretization
    hd = subs(h,[x;u;t],[xk;uk;tk]);
    
end