%==========================================================================
%
% h2D_fun  Continuous feedforward Jacobian from continuous measurement
% equation.
%
%   D = h2D_fun(h)
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
%   D       - (1×1 function_handle) continuous feedforward Jacobian, 
%             D(x,u,t) (D : ℝⁿ×ℝᵐ×ℝ → ℝᵖˣᵐ)
%
%==========================================================================
function D = h2D_fun(h)
    D = @(x,u,t) ijacobian(@(u)h(x,u,t),u);
end