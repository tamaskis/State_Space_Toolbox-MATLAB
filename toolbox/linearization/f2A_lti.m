%==========================================================================
%
% f2A_lti  Continuous dynamics Jacobian from continuous dynamics equation
% via linearization about an equilibrium point.
%
%   A = f2A_lti(f,xe)
%   A = f2A_lti(f,xe,ue)
%   A = f2A_lti(f,xe,[],tl)
%   A = f2A_lti(f,xe,ue,tl)
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
% https://tamaskis.github.io/documentation/State_Space_Systems_Linearization_Discretization_and_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) continuous dynamics equation,
%             dx/dt = f(x,u,t) (f : ℝⁿ×ℝᵐ×ℝ → ℝⁿ)
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) (OPTIONAL) equilibrium control input, uₑ
%   tl      - (1×1 double) (OPTIONAL) time at linearization, tₗ
%
% -------
% OUTPUT:
% -------
%   A       - (n×n double) continuous dynamics Jacobian
%
%==========================================================================
function A = f2A_lti(f,xe,ue,tl)
    
    % defaults equilibrium input to empty vector
    if (nargin < 3)
        ue = [];
    end
    
    % defaults time at linearization to empty vector
    if (nargin < 4)
        tl = [];
    end
    
    % continuous dynamics Jacobian
    A = ijacobian(@(x)f(x,ue,tl),xe);
    
end