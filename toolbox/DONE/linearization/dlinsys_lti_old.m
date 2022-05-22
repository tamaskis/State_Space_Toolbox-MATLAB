%==========================================================================
%
% dlinsys_lti  Linearize a discrete-time state space system (numerical
% approximation).
%
%   [F,G,H,J] = dlinsys_lti(fd,hd,xe,ue)
%   [F,G,H,J] = dlinsys_lti(fd,hd,xe,ue,kl)
%
% See also fd2F_lti, fd2G_lti, fd2H_lti.
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
%   fd      - (1×1 function_handle) discrete dynamics equation,
%             xₖ₊₁ = fd(xₖ,uₖ,k) (fd : ℝⁿ×ℝᵐ×ℤ → ℝⁿ)
%   hd      - (1×1 function_handle) (OPTIONAL) discrete measurement 
%             equation, yₖ = hd(xₖ,k) (hd : ℝⁿ×ℤ → ℝᵖ)
%   xk      - (n×1 double) state vector at kth sample
%   uk      - (m×1 double) control input at kth sample
%   k       - (1×1 double) (OPTIONAL) sample number
%
% ---------------------------------------------------
% INPUT (linearization about equilbrium state/input):
% ---------------------------------------------------
%   fd      - (1×1 function_handle) discrete dynamics equation,
%             xₖ₊₁ = fd(xₖ,uₖ,k) (fd : ℝⁿ×ℝᵐ×ℤ → ℝⁿ)
%   hd      - (1×1 function_handle) (OPTIONAL) discrete measurement
%             equation, yₖ = hd(xₖ,k) (hd : ℝⁿ×ℤ → ℝᵖ)
%   xe      - (n×1 double) equilibrium state vector
%   ue      - (m×1 double) equilibrium control input
%   k       - (OPTIONAL) (1×1 double) sample number
%
% -------
% OUTPUT:
% -------
%   F       - (n×n sym) discrete dynamics Jacobian at kth sample
%   G       - (n×m sym) discrete input Jacobian at kth sample
%   H       - (p×n sym) discrete measurement Jacobian at kth sample
%
% -----
% NOTE:
% -----
%   --> If h is not input, H is returned as NaN.
%
%==========================================================================
function [F,G,H] = dlinsys_lti(fd,hd,x,u,k)
    
    % defaults sample number to empty vector if not specified
    if (nargin < 5)
        k = 0;
    end
    
    % discrete dynamics Jacobian
    F = fd2F_lti(fd,x,u,k);
    
    % discrete input Jacobian
    G = fd2G_lti(fd,x,u,k);
    
    % discrete measurement Jacobian
    if isempty(hd)
        H = NaN;
    else
        H = hd2H_lti(hd,x,u,k);
    end
    
end