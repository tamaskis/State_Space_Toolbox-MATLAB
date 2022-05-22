%==========================================================================
%
% fd2F_lti  Discrete dynamics Jacobian from discrete dynamics equation
% via linearization about an equilibrium point.
%
%   F = fd2F_lti(fd,xe)
%   F = fd2F_lti(fd,xe,ue)
%   F = fd2F_lti(fd,xe,[],kl)
%   F = fd2F_lti(fd,xe,ue,kl)
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
%   fd      - (1×1 function_handle) discrete dynamics equation,
%             xₖ₊₁ = fd(xₖ,uₖ,k) (fd : ℝⁿ×ℝᵐ×ℤ → ℝⁿ)
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) (OPTIONAL) equilibrium control input, uₑ
%   kl      - (1×1 double) (OPTIONAL) sample number at linearization, kₗ
%
% -------
% OUTPUT:
% -------
%   F       - (n×n double) discrete dynamics Jacobian
%
%==========================================================================
function F = fd2F_lti(fd,xe,ue,kl)
    
    % defaults control input to empty vector
    if (nargin < 3)
        ue = [];
    end
    
    % defaults sample number to empty vector
    if (nargin < 4)
        kl = [];
    end
    
    % discrete dynamics Jacobian
    F = ijacobian(@(xk)fd(xk,ue,kl),xe);
    
end