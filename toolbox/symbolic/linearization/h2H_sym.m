%==========================================================================
%
% h2H_sym  Discrete measurement Jacobian from continuous measurement
% equation.
%
%   H = h2H_sym(h,x)
%   H = h2H_sym(h,x,xe)
%   H = h2H_sym(h,x,xe,u,ue)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
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
%   H       - (p×n sym) discrete measurement Jacobian at kth sample time
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