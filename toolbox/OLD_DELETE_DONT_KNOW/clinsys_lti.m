%==========================================================================
%
% clinsys_lti  Linearize a continuous-time state space system about an
% equilibrium point.
%
%   [A,B,C,D] = clinsys_lti(f,h,xe,ue)
%   [A,B,C,D] = clinsys_lti(f,h,xe,ue,tl)
%
% See also TODO.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-05-22
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/State_Space_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   h       - (1×1 function_handle) (OPTIONAL) continuous measurement 
%             equation, y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) equilibrium control input, uₑ
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
    
    % defaults time at linearization to empty vector
    if (nargin < 5)
        tl = [];
    end
    
    % performs linearizations
    A = f2A_lti(f,xe,ue,tl);
    B = f2B_lti(f,xe,ue,tl);
    C = h2C_lti(h,xe,ue,tl);
    D = h2D_lti(h,xe,ue,tl);
    
end