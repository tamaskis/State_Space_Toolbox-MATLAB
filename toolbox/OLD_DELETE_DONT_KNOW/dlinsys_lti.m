%==========================================================================
%
% dlinsys_lti  Linearize a discrete-time state space system about an
% equilibrium point.
%
%   [F,G,H,J] = dlinsys_lti(fd,hd,xe,ue)
%   [F,G,H,J] = dlinsys_lti(fd,hd,xe,ue,kl)
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
%   fd      - (1×1 function_handle) discrete dynamics equation,
%             xₖ₊₁ = fd(xₖ,uₖ,k) (fd : ℝⁿ×ℝᵐ×ℤ → ℝⁿ)
%   hd      - (1×1 function_handle) discrete measurement equation, 
%             yₖ = hd(xₖ,uₖ,k) (hd : ℝⁿ×ℝᵐ×ℤ → ℝᵖ)
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) equilibrium control input, uₑ
%   kl      - (1×1 double) (OPTIONAL) sample number at linearization, kₗ
%
% -------
% OUTPUT:
% -------
%   F       - (n×n double) discrete dynamics Jacobian
%   G       - (n×m double) discrete input Jacobian
%   H       - (p×n double) discrete measurement Jacobian
%   J       - (p×m double) discrete feedforward Jacobian
%
%==========================================================================
function [F,G,H,J] = dlinsys_lti(fd,hd,xe,ue,kl)
    
    % defaults sample number at linearization to empty vector
    if (nargin < 5)
        kl = [];
    end
    
    % performs linearizations
    F = fd2F_lti(fd,xe,ue,kl);
    G = fd2G_lti(fd,xe,ue,kl);
    H = hd2H_lti(hd,xe,ue,kl);
    J = hd2J_lti(hd,xe,ue,kl);
    
end