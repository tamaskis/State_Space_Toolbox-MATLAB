%==========================================================================
%
% hd2H_fun  Discrete measurement Jacobian from discrete measurement
% equation.
%
%   H = hd2H_fun(hd,d)
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
%   hd      - (1×1 function_handle) discrete measurement equation, 
%             yₖ = hd(xₖ,uₖ,k) (hd : ℝⁿ×ℝᵐ×ℤ → ℝᵖ)
%   d       - (1×1 Differentiator) differentiator
%
% -------
% OUTPUT:
% -------
%   H       - (1×1 function_handle) discrete measurement Jacobian, 
%             Hₖ = H(xₖ,uₖ,k) (H : ℝⁿ×ℝᵐ×ℤ → ℝᵖˣⁿ)
%
%==========================================================================
function H = hd2H_fun(hd,d)
    H = @(xk,uk,k) d.jacobian(@(x)hd(x,uk,k),xk);
end