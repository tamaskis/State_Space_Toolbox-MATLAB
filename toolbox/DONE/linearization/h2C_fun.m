%==========================================================================
%
% h2C_fun  Discrete measurement Jacobian from continuous measurement
% equation.
%
%   H = h2C_fun(h)
%
% Author: Tamas Kis
% Last Update: 2022-05-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   h       - (1×1 function_handle) continuous measurement equation, can 
%             have 2 or 3 input arguments:
%               --> y = h(x,t) (h : ℝⁿ×ℝ → ℝᵖ)
%               --> y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%
% -------
% OUTPUT:
% -------
%   C       - (1×1 function_handle) continuous measurement Jacobian, with
%             same number of input arguments as h:
%               --> C(t) = C(x,t) (C : ℝⁿ×ℝ → ℝᵖˣⁿ) if h(x,t) input
%               --> C(t) = C(x,u,t) (C : ℝⁿ×ℝᵐ×ℝ → ℝᵖˣⁿ) if h(x,u,t) input
%
%==========================================================================
function C = h2C_fun(h)
    
    % assumes h has three input arguments (i.e. h(x,u,t))
    num_arg = 3;
    
    % updates "num_arg" to 2 if h is really input as h(x,t)
    try
        h(0,0,0);
    catch
        num_arg = 2;
    end
    
    % function handle for C(x,t)
    if num_arg == 2
        C = @(x,t) ijacobian(@(x)h(x,t),x);
    
    % function handle for C(x,u,t)
    else
        C = @(x,u,t) ijacobian(@(x)h(x,u,t),x);
    
    end
    
end