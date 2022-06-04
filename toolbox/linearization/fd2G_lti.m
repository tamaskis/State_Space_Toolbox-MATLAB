%==========================================================================
%
% fd2G_lti  Discrete input Jacobian from discrete dynamics equation 
% via linearization about an equilibrium point.
%
%   G = fd2G_lti(fd,xe,ue)
%
% See also TODO.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-06-03
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
%
% -------
% OUTPUT:
% -------
%   G       - (n×m double) discrete input Jacobian
%
%==========================================================================
function G = fd2G_lti(fd,xe,ue)
    G = ijacobian(@(uk)fd(xe,uk,0),ue);
end