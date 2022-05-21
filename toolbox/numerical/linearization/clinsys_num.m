%==========================================================================
%
% clinsys_num  Linearize a continuous-time state space system (numerical
% approximation).
%
%   [A,B] = clinsys_num(f,[],x,u)
%   [A,B] = clinsys_num(f,[],xe,ue)
%   [A,B,C] = clinsys_num(f,h,x,u)
%   [A,B,C] = clinsys_num(f,h,xe,ue)
%   [__] = clinsys_num(__,t)
%
% See also f2A_num, f2B_num, h2C_num.
%
% Author: Tamas Kis
% Last Update: 2022-02-25
%
% REFERENCES:
%   [1] TODO
%
%--------------------------------------------------------------------------
%
% -------------------------------------------------------------
% INPUT (linearization about nominal or estimated state/input):
% -------------------------------------------------------------
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   h       - (1×1 function_handle) (OPTIONAL) continuous measurement 
%             equation, y = h(x,t) (h : ℝⁿ×ℝ → ℝᵖ)
%   x       - (n×1 double) state vector
%   u       - (m×1 double) control input
%   t       - (1×1 double) (OPTIONAL) time
%
% ---------------------------------------------------
% INPUT (linearization about equilbrium state/input):
% ---------------------------------------------------
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   h       - (1×1 function_handle) (OPTIONAL) continuous measurement 
%             equation, y = h(x,t) (h : ℝⁿ×ℝ → ℝᵖ)
%   xe      - (n×1 double) equilibrium state vector
%   ue      - (m×1 double) equilibrium control input
%   t       - (1×1 double) (OPTIONAL) time
%
% -------
% OUTPUT:
% -------
%   A       - (n×n sym) continuous dynamics Jacobian
%   B       - (n×m sym) continuous input Jacobian
%   C       - (p×n sym) continuous measurement Jacobian
%
% -----
% NOTE:
% -----
%   --> If h is not input, C is returned as NaN.
%
%==========================================================================
function [A,B,C] = clinsys_num(f,h,x,u,t)
    
    % defaults time to empty vector if not specified
    if (nargin < 5)
        t = [];
    end
    
    % continuous dynamics Jacobian
    A = f2A_num(f,x,u,t);
    
    % continuous input Jacobian
    B = f2B_num(f,x,u,t);
    
    % continuous measurement Jacobian
    if isempty(h)
        C = NaN;
    else
        C = h2C_num(h,x,u,t);
    end
    
end