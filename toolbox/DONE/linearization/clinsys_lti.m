%==========================================================================
%
% clinsys_lti  Linearize a continuous-time state space system about an
% equilibrium point.
%
%   [A,B] = clinsys_lti(f,[],xe,ue)
%   [A,C] = clinsys_lti(f,h,xe)
%   [A,B,C,D] = clinsys_lti(f,h,xe,ue)
%   [__] = clinsys_lti(__,tl)
%
% Author: Tamas Kis
% Last Update: 2022-05-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   h       - (1×1 function_handle) (OPTIONAL) continuous measurement 
%             equation, can have 2 or 3 input arguments:
%               --> y = h(x,t) (h : ℝⁿ×ℝ → ℝᵖ)
%               --> y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) (OPTIONAL) equilibrium control input, uₑ
%   tl      - (1×1 double) (OPTIONAL) time at linearization, tₗ
%
% -------
% OUTPUT:
% -------
%   A       - (n×n double) continuous dynamics Jacobian
%   B       - (n×m double) continuous input Jacobian
%   C       - (p×n double) continuous measurement Jacobian
%   D       - (p×m double) continuous feedforward Jacobian
%
%==========================================================================
function [A,B,C,D] = clinsys_lti(f,h,xe,ue,tl)
    
    % defaults equilibrium control input to empty vector if not specified
    if (nargin < 4)
        ue = [];
    end
    
    % defaults time at linearization to empty vector if not specified
    if (nargin < 5)
        tl = [];
    end
    
    % continuous dynamics Jacobian
    A = f2A_lti(f,xe,ue,tl);
    
    % continuous input Jacobian
    B = f2B_lti(f,xe,ue,tl);
    
    % continuous measurement and feedforward Jacobians
    if isempty(h)
        C = NaN;
        D = NaN;
    else
        C = h2C_lti(h,xe,ue,tl);
        D = h2D_lti(h,xe,ue,tl);
    end
    
end