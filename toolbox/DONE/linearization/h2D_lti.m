%==========================================================================
%
% h2D_lti  Continuous feedforward Jacobian from continuous measurement
% equation.
%
%   D = h2D_lti(h,xe,ue)
%   D = h2D_lti(h,xe,ue,tl)
%
% Author: Tamas Kis
% Last Update: 2022-05-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   h       - (1×1 function_handle) continuous measurement equation, 
%             y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) sequilibrium control input, uₑ
%   tl      - (1×1 double) (OPTIONAL) time at linearization, tₗ
%
% -------
% OUTPUT:
% -------
%   D       - (p×m double) continuous feedforward Jacobian
%
% -----
% NOTE:
% -----
%   --> If linearizing about equilibrium point (xₑ,uₑ), input xₑ for x and
%       uₑ for u.
%
%==========================================================================
function D = h2D_lti(h,xe,ue,tl)
    
    % assumes h has three input arguments (i.e. h(x,u,t))
    num_arg = 3;
    
    % updates "num_arg" to 2 if h is really input as h(x,t)
    try
        h(0,0,0);
    catch
        num_arg = 2;
    end
    
    % defaults time to empty vector if not specified
    if (nargin < 4)
        tl = [];
    end
    
    % continuous measurement Jacobian
    if num_arg == 3
        D = ijacobian(@(u)h(xe,u,tl),ue);
    else
        D = 0;
    end
    
end