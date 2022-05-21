%==========================================================================
%
% h2D_fun  Continuous feedforward Jacobian from continuous measurement
% equation.
%
%   D = h2D_fun(h)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
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
%             D(t) = D(x,u,t) (D : ℝⁿ×ℝᵐ×ℝ → ℝᵖˣᵐ)
%
%==========================================================================
function D = h2D_fun(h)
    D = @(x,u,t) h2D_num(h,x,u,t);
end