%==========================================================================
%
% f2A_fun  Continuous dynamics Jacobian from continuous dynamics equation.
%
%   A = f2A_fun(f)
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
%   A       - (1×1 function_handle) continuous dynamics Jacobian, 
%             A(t) = A(x,u,t) (A : ℝⁿ×ℝᵐ×ℝ → ℝⁿˣⁿ)
%
%==========================================================================
function A = f2A_fun(f)
    A = @(x,u,t) f2A_num(f,x,u,t);
end