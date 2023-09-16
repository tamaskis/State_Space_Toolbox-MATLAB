%==========================================================================
%
% f2B_lti  Continuous input Jacobian from continuous dynamics equation 
% via linearization about an equilibrium point.
%
%   B = f2B_lti(f,d,xe,ue)
%
% See also TODO.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-09-14
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
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   d       - (1×1 Differentiator) differentiator
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   B       - (n×m double) continuous input Jacobian
%
%==========================================================================
function B = f2B_lti(f,d,xe,ue)
    B = d.jacobian(@(u)f(xe,u,0),ue);
end