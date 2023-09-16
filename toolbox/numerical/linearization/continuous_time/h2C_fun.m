%==========================================================================
%
% h2C_fun  Continuous measurement Jacobian from continuous measurement
% equation.
%
%   H = h2C_fun(h,d)
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
%   h       - (1×1 function_handle) continuous measurement equation, 
%             y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%   d       - (1×1 Differentiator) differentiator
%
% -------
% OUTPUT:
% -------
%   C       - (1×1 function_handle) continuous measurement Jacobian, 
%             C(x,u,t) (C : ℝⁿ×ℝᵐ×ℝ → ℝᵖˣⁿ)
%
%==========================================================================
function C = h2C_fun(h,d)
    C = @(x,u,t) d.jacobian(@(x)h(x,u,t),x);
end