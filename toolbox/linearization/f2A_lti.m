%==========================================================================
%
% f2A_lti  Continuous dynamics Jacobian from continuous dynamics equation
% via linearization about an equilibrium point.
%
%   A = f2A_lti(f,xe)
%   A = f2A_lti(f,xe,ue)
%
% See also TODO.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-06-03
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
%
% -------
% OUTPUT:
% -------
%   A       - (n×n double) continuous dynamics Jacobian
%
%==========================================================================
function A = f2A_lti(f,xe,ue)
    
    % defaults equilibrium control input to empty vector
    if (nargin < 3)
        ue = [];
    end
    
    % continuous dynamics Jacobian
    A = ijacobian(@(x)f(x,ue,0),xe);
    
end