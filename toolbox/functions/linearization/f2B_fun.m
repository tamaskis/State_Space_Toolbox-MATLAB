%==========================================================================
%
% f2B_fun  Continuous input Jacobian from continuous dynamics equation.
%
%   A = f2B_fun(f)
%
% Author: Tamas Kis
% Last Update: 2022-03-31
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
%   B       - (1×1 function_handle) continuous input Jacobian, 
%             B(t) = B(x,u,t) (B : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣᵐ)
%
%==========================================================================
function B = f2B_fun(f)
    B = @(x,u,t) f2B_num(f,x,u,t);
end