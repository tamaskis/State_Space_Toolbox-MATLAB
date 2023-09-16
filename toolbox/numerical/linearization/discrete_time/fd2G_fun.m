%==========================================================================
%
% fd2G_fun  Discrete input Jacobian from discrete dynamics equation.
%
%   F = fd2G_fun(fd,d)
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
%   fd      - (1×1 function_handle) discrete dynamics equation,
%             xₖ₊₁ = fd(xₖ,uₖ,k) (fd : ℝⁿ×ℝᵐ×ℤ → ℝⁿ)
%   d       - (1×1 Differentiator) differentiator
%
% -------
% OUTPUT:
% -------
%   G       - (1×1 function_handle) discrete input Jacobian, Gₖ = G(xₖ,uₖ,k)
%             (G : ℝⁿ×ℝᵐ×ℤ → ℝⁿˣᵐ)
%
%==========================================================================
function G = fd2G_fun(fd,d)
    G = @(xk,uk,k) d.jacobian(@(u)fd(xk,u,k),uk);
end