%==========================================================================
%
% f2B_fun  Continuous input Jacobian from continuous dynamics equation.
%
%   A = f2B_fun(f)
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
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%
% -------
% OUTPUT:
% -------
%   B       - (1×1 function_handle) continuous input Jacobian, B(x,u,t) 
%             (B : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣᵐ)
%
%==========================================================================
function B = f2B_fun(f)
    B = @(x,u,t) ijacobian(@(u)f(x,u,t),u);
end