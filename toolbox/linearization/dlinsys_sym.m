%==========================================================================
%
% dlinsys_sym  Linearize a discrete-time state space system.
%
%   [F,G,H,J] = dlinsys_sym(fd,hd,xk,uk)
%   [F,G,H,J] = dlinsys_sym(fd,hd,xk,uk,xe,ue)
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
%   fd      - (n×1 sym) continuous dynamics equation
%   hd      - (p×1 sym) continuous measurement equation
%   xk      - (n×1 sym) state vector at kth sample, xₖ
%   uk      - (m×1 sym) control input at kth sample, uₖ
%   xe      - (n×1 sym) (OPTIONAL) equilibrium state vector, xₑ
%   ue      - (m×1 sym) (OPTIONAL) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   F       - (n×n sym) discrete dynamics Jacobian
%   G       - (n×m sym) discrete input Jacobian
%   H       - (p×n sym) discrete measurement Jacobian
%   J       - (p×m sym) discrete feedforward Jacobian
%
%==========================================================================
function [F,G,H,J] = dlinsys_sym(fd,hd,xk,uk,xe,ue)
    
    % defaults equilibrium state vector to empty vector if not specified
    if (nargin < 5) || isempty(xe)
        xe = [];
    end
    
    % defaults equilibrium control input to empty vector if not specified
    if (nargin < 6) || isempty(ue)
        ue = [];
    end
    
    % performs linearizations
    F = fd2F_sym(fd,xk,xe,uk,ue);
    G = fd2G_sym(fd,uk,ue,xk,xe);
    H = hd2H_sym(hd,xk,xe,uk,ue);
    J = hd2J_sym(hd,uk,ue,xk,xe);
    
end