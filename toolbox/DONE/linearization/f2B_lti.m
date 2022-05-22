%==========================================================================
%
% f2B_lti  Continuous input Jacobian from continuous dynamics equation 
% via linearization about an equilibrium point.
%
%   B = f2B_lti(f,xe,ue)
%   B = f2B_lti(f,xe,ue,tl)
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
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) equilibrium control input, uₑ
%   tl      - (1×1 double) (OPTIONAL) time at linearization, tₗ
%
% -------
% OUTPUT:
% -------
%   B       - (n×m double) continuous input Jacobian
%
%==========================================================================
function B = f2B_lti(f,xe,ue,tl)
    
    % defaults time at linearization to empty vector if not specified
    if (nargin < 4)
        tl = [];
    end
    
    % continuous input Jacobian
    B = ijacobian(@(u)f(xe,u,tl),ue);
    
end