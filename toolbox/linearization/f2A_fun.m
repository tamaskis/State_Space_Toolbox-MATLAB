%==========================================================================
%
% f2A_fun  Continuous dynamics Jacobian from continuous dynamics equation.
%
%   A = f2A_fun(f)
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
%   A       - (1×1 function_handle) continuous dynamics Jacobian, A(x,u,t) 
%             (A : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣⁿ)
%
%==========================================================================
function A = f2A_fun(f)
    A = @(x,u,t) ijacobian(@(x)f(x,u,t),x);
end