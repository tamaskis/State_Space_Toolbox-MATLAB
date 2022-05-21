%==========================================================================
%
% fd2G_fun  Discrete input Jacobian from discrete dynamics equation.
%
%   F = fd2G_fun(fd)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   fd      - (1×1 function_handle) discrete dynamics equation,
%             xₖ₊₁ = fd(xₖ,uₖ,k) (fd : ℝⁿ×ℝᵐ×ℤ → ℝⁿ)
%
% -------
% OUTPUT:
% -------
%   G       - (1×1 function_handle) discrete input Jacobian, Gₖ = G(xₖ,uₖ,k)
%             (G : ℝⁿ×ℝᵐ×ℤ → ℝⁿˣᵐ)
%
%==========================================================================
function G = fd2G_fun(fd)
    G = @(xk,uk,k) fd2G_num(fd,xk,uk,k);
end