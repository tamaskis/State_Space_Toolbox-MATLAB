%==========================================================================
%
% hd2J_fun  Discrete feedforward Jacobian from discrete measurement
% equation.
%
%   J = hd2J_fun(hd)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
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
%             J(x,u,t) (J : ℝⁿ×ℝᵐ×ℤ → ℝᵖˣᵐ)
%
%==========================================================================
function J = hd2J_fun(hd)
    J = @(xk,uk,k) hd2J_num(hd,xk,uk,k);
end