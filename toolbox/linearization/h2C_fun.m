%==========================================================================
%
% h2C_fun  Continuous measurement Jacobian from continuous measurement
% equation.
%
%   H = h2C_fun(h)
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
%
% -------
% OUTPUT:
% -------
%   C       - (1×1 function_handle) continuous measurement Jacobian, 
%             C(x,u,t) (C : ℝⁿ×ℝᵐ×ℝ → ℝᵖˣⁿ)
%
%==========================================================================
function C = h2C_fun(h)
    C = @(x,u,t) ijacobian(@(x)h(x,u,t),x);
end