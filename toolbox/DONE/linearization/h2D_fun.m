%==========================================================================
%
% h2D_fun  Continuous feedforward Jacobian from continuous measurement
% equation.
%
%   D = h2D_fun(h)
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
%   D       - (1×1 function_handle) continuous feedforward Jacobian, with
%             same number of input arguments as h:
%               --> D(t) = D(x,t) (D : ℝⁿ×ℝ → ℝᵖˣᵐ) if h(x,t) input
%               --> D(t) = D(x,u,t) (D : ℝⁿ×ℝᵐ×ℝ → ℝᵖˣᵐ) if h(x,u,t) input
%
% -----
% NOTE:
% -----
%   --> If "h" is input as h(x,t), then by definition, D = 0
%
%==========================================================================
function D = h2D_fun(h)
    
    % assumes h has three input arguments (i.e. h(x,u,t))
    num_arg = 3;
    
    % updates "num_arg" to 2 if h is really input as h(x,t)
    try
        h(0,0,0);
    catch
        num_arg = 2;
    end
    
    % function handle for D(x,t)
    if num_arg == 2
        D = @(x,t) 0;
        
    % function handle for D(x,u,t)
    else
        D = @(x,u,t) ijacobian(@(u)h(x,u,t),u);
        
    end
    
end