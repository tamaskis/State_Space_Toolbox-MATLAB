%==========================================================================
%
% h2hd_sym  Discretization of continuous nonlinear measurement.
%
%   hd = h2hd_sym(h,x)
%   hd = h2hd_sym(h,x,u)
%   hd = h2hd_sym(h,x,[],t)
%   hd = h2hd_sym(h,x,u,t)
%   [hd,xk,uk] = h2hd_sym(__)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   h       - (p×1 sym) continuous nonlinear measurement equation
%   x       - (n×1 sym) state vector
%   u       - (m×1 sym) (OPTIONAL) control input
%   t       - (1×1 sym) (OPTIONAL) time
%
% -------
% OUTPUT:
% -------
%   hd      - (p×1 sym) discrete nonlinear measurement equation
%   xk      - (n×1 sym) state vector at kth sample
%   uk      - (m×1 sym) control input at kth sample
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