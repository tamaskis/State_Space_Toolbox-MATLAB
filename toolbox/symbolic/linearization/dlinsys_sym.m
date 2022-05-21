%==========================================================================
%
% dlinsys_sym  Linearize a discrete-time state space system.
%
%   [F,G] = dlinsys_sym(fd,[],xk,uk)
%   [F,G] = dlinsys_sym(fd,[],xk,uk,xe,ue)
%   [F,G,H,E] = dlinsys_sym(fd,hd,xk,uk)
%   [F,G,H,E] = dlinsys_sym(fd,hd,xk,uk,xe,ue)
%
% See also TODO.
%
% Author: Tamas Kis
% Last Update: 2022-02-25
%
% REFERENCES:
%   [1] TODO
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   fd      - (n×1 sym) discrete dynamics equation
%   hd      - (p×1 sym) discrete measurement equation
%   xk      - (n×1 sym) state vector at kth sample
%   uk      - (m×1 sym) control input at kth sample
%   xe      - (n×1 sym) equilibrium state vector
%   ue      - (m×1 sym) equilibrium control input
%
% -------
% OUTPUT:
% -------
%   F       - (n×n sym) discrete dynamics Jacobian at kth sample
%   G       - (n×m sym) discrete input Jacobian at kth sample
%   H       - (p×n sym) discrete measurement Jacobian at kth sample
%   E       - (p×m sym) discrete feedforward Jacobian at kth sample
%
% -----
% NOTE:
% -----
%   --> If h is not input, H and E are returned as NaN.
%
%==========================================================================
function [F,G,H,E] = dlinsys_sym(fd,hd,xk,uk,xe,ue)
    
    % defaults equilibrium state vector to empty vector if not specified
    if (nargin < 5) || isempty(xe)
        xe = [];
    end
    
    % defaults equilibrium control input to empty vector if not specified
    if (nargin < 6) || isempty(ue)
        ue = [];
    end
    
    % discrete dynamics Jacobian
    F = fd2F_sym(fd,xk,xe,uk,ue);
    
    % discrete input Jacobian
    G = fd2G_sym(fd,uk,ue,xk,xe);
    
    % discrete measurement Jacobian
    if isempty(hd)
        H = NaN;
    else
        H = hd2H_sym(hd,xk,xe,uk,ue);
    end
    
    % discrete feedforward Jacobian
    if isempty(hd)
        E = NaN;
    else
        E = hd2E_sym(hd,uk,ue,xk,xe);
    end
    
end