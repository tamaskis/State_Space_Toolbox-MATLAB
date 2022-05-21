%==========================================================================
%
% f2G_sym  Discrete input Jacobian from continuous dynamics equation 
% (1st-order approximation).
%
%   G = f2G_sym(f,x,u)
%   G = f2G_sym(f,x,u,xe,ue)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (n×1 sym) continuous dynamics equation
%   x       - (n×1 sym) state vector
%   u       - (m×1 sym) control input
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input
%
% -------
% OUTPUT:
% -------
%   G       - (n×m sym) discrete input Jacobian at kth sample time
%
%==========================================================================
function G = f2G_sym(f,x,u,xe,ue)
    
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
    
    % discrete dynamics equation from continuous dynamics equation
    [fd,xk,uk] = f2fd_sym(f,x,u,t);
    
    % discrete input Jacobian from discrete dynamics equation
    G = fd2G_sym(fd,uk,ue,xk,xe);
    
end