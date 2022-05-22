%==========================================================================
%
% h2C_lti  Continuous measurement Jacobian from continuous measurement
% equation.
%
%   C = h2C_lti(h,xe)
%   C = h2C_lti(h,xe,ue)
%   C = h2C_lti(h,xe,[],tl)
%   C = h2C_lti(h,xe,ue,tl)
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
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) (OPTIONAL) equilibrium control input, uₑ
%   tl      - (1×1 double) (OPTIONAL) time at linearization, tₗ
%
% -------
% OUTPUT:
% -------
%   C       - (p×n double) continuous measurement Jacobian
%
%==========================================================================
function C = h2C_lti(h,xe,ue,tl)
    
    % assumes h has three input arguments (i.e. h(x,u,t))
    num_arg = 3;
    
    % updates "num_arg" to 2 if h is really input as h(x,t)
    try
        h(0,0,0);
    catch
        num_arg = 2;
    end
    
    % defaults control input to empty vector if not specified
    if (nargin < 3)
        ue = [];
    end
    
    % defaults time at linearization to empty vector if not specified
    if (nargin < 4)
        tl = [];
    end
    
    % continuous measurement Jacobian
    if num_arg == 3
        C = ijacobian(@(x)h(x,ue,tl),xe);
    else
        C = ijacobian(@(x)h(x,tl),xe);
    end
    
end