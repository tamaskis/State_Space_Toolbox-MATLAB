%==========================================================================
%
% f2F_sym  Discrete dynamics Jacobian from continuous dynamics equation
% (1st-order approximation).
%
%   F = f2F_sym(f,x)
%   F = f2F_sym(f,x,xe)
%   F = f2F_sym(f,x,xe,u,ue)
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
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector
%   u       - (m×1 sym) (OPTIONAL) control input
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input
%
% -------
% OUTPUT:
% -------
%   F       - (n×n sym) discrete dynamics Jacobian at kth sample time
%
%==========================================================================
function F = f2F_sym(f,x,xe,u,ue)
    
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
    
    % discrete dynamics equation from continuous dynamics equation
    [fd,xk,uk] = f2fd_sym(f,x,u,t);
    
    % discrete dynamics Jacobian from discrete dynamics equation
    F = fd2F_sym(fd,xk,xe,uk,ue);
    
end