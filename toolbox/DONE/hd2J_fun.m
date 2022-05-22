%==========================================================================
%
% hd2J_fun  Discrete feedforward Jacobian from discrete measurement
% equation.
%
%   J = hd2J_fun(hd)
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
%   hd      - (1×1 function_handle) discrete measurement equation,
%             yₖ = hd(xₖ,uₖ,k) (hd : ℝⁿ×ℝᵐ×ℤ → ℝᵖ)
%
% -------
% OUTPUT:
% -------
%   J       - (1×1 function_handle) discrete feedforward Jacobian,
%             Jₖ = J(x,u,t) (J : ℝⁿ×ℝᵐ×ℤ → ℝᵖˣᵐ)
%
%==========================================================================
function J = hd2J_fun(hd)
    J = @(xk,uk,k) hd2J_num(hd,xk,uk,k);
end