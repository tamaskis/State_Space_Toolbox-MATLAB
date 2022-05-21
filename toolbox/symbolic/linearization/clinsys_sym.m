%==========================================================================
%
% clinsys_sym  Linearize a continuous-time state space system.
%
%   [A,B] = clinsys_sym(f,[],x,u)
%   [A,B] = clinsys_sym(f,[],x,u,xe,ue)
%   [A,B,C,D] = clinsys_sym(f,h,x,u)
%   [A,B,C,D] = clinsys_sym(f,h,x,u,xe,ue)
%
% See also f2A_sym, f2B_sym, h2C_sym, h2D_sym, clinsys_sym.
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
%   f       - (n×1 sym) continuous dynamics equation
%   h       - (p×1 sym) continuous measurement equation
%   x       - (n×1 sym) state vector
%   u       - (m×1 sym) control input
%   xe      - (n×1 sym) equilibrium state vector
%   ue      - (m×1 sym) equilibrium control input
%
% -------
% OUTPUT:
% -------
%   A       - (n×n sym) continuous dynamics Jacobian
%   B       - (n×m sym) continuous input Jacobian
%   C       - (p×n sym) continuous measurement Jacobian
%   D       - (p×m sym) continuous feedforward Jacobian
%
% -----
% NOTE:
% -----
%   --> If h is not input, C and D are returned as NaN.
%
%==========================================================================
function [A,B,C,D] = clinsys_sym(f,h,x,u,xe,ue)
    
    % defaults equilibrium state vector to empty vector if not specified
    if (nargin < 5) || isempty(xe)
        xe = [];
    end
    
    % defaults equilibrium control input to empty vector if not specified
    if (nargin < 6) || isempty(ue)
        ue = [];
    end
    
    % continuous dynamics Jacobian
    A = f2A_sym(f,x,xe,u,ue);
    
    % continuous input Jacobian
    B = f2B_sym(f,u,ue,x,xe);
    
    % continuous measurement Jacobian
    if isempty(h)
        C = NaN;
    else
        C = h2C_sym(h,x,xe,u,ue);
    end
    
    % continuous feedforward Jacobian
    if isempty(h)
        D = NaN;
    else
        D = h2D_sym(h,u,ue,x,xe);
    end
    
end