%==========================================================================
%
% h2J_sym  Discrete feedforward Jacobian from continuous measurement
% equation.
%
%   J = h2J_sym(h,x,u)
%   J = h2J_sym(h,x,u,xe,ue)
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
%   u       - (m×1 sym) control input
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input
%
% -------
% OUTPUT:
% -------
%   J       - (p×m sym) discrete feedforward Jacobian at kth sample time
%
%==========================================================================
function J = h2J_sym(h,x,u,xe,ue)
    
    % defaults xe to empty vector if not input
    if (nargin < 4)
        xe = [];
    end
    
    % defaults ue to empty vector if not input
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