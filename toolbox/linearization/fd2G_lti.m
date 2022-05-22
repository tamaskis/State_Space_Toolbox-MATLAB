%==========================================================================
%
% fd2G_lti  Discrete input Jacobian from discrete dynamics equation 
% via linearization about an equilibrium point.
%
%   G = fd2G_lti(fd,xe,ue)
%   G = fd2G_lti(fd,xe,ue,kl)
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
%   ue      - (m×1 double) equilibrium control input, uₑ
%   kl      - (1×1 double) (OPTIONAL) sample number at linearization, kₗ
%
% -------
% OUTPUT:
% -------
%   G       - (n×m double) discrete input Jacobian
%
%==========================================================================
function G = fd2G_lti(fd,xe,ue,kl)
    
    % defaults sample number to empty vector
    if (nargin < 4)
        kl = [];
    end
    
    % evaluates discrete input Jacobian
    G = ijacobian(@(uk)fd(xe,uk,kl),ue);
    
end