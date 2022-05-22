%==========================================================================
%
% h2C_lti  Continuous measurement Jacobian from continuous measurement
% equation via linearization about an equilibrium point.
%
%   C = h2C_lti(h,xe)
%   C = h2C_lti(h,xe,ue)
%   C = h2C_lti(h,xe,[],tl)
%   C = h2C_lti(h,xe,ue,tl)
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
%   h       - (1×1 function_handle) continuous measurement equation, 
%             y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) (OPTIONAL) equilibrium control input, uₑ
%   tl      - (1×1 double) (OPTIONAL) time at linearization, tₗ
%
% -------
% OUTPUT:
% -------
%   C       - (p×n double) continuous measurement Jacobian
%
%==========================================================================
function C = h2C_lti(h,xe,ue,tl)
    C = ijacobian(@(x)h(x,ue,tl),xe);
end