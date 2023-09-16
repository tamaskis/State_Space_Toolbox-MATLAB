%==========================================================================
%
% h2C_lti  Continuous measurement Jacobian from continuous measurement
% equation via linearization about an equilibrium point.
%
%   C = h2C_lti(h,d,xe)
%   C = h2C_lti(h,d,xe,ue)
%
% See also TODO.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-09-14
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
%   h       - (1×1 function_handle) continuous measurement equation, 
%             y = h(x,u,t) (h : ℝⁿ×ℝᵐ×ℝ → ℝᵖ)
%   d       - (1×1 Differentiator) differentiator
%   xe      - (n×1 double) equilibrium state vector, xₑ
%   ue      - (m×1 double) (OPTIONAL) equilibrium control input, uₑ
%
% -------
% OUTPUT:
% -------
%   C       - (p×n double) continuous measurement Jacobian
%
%==========================================================================
function C = h2C_lti(h,d,xe,ue)
    
    % defaults equilibrium control input to empty vector
    if (nargin < 4)
        ue = [];
    end
    
    % continuous measurement Jacobian
    C = d.jacobian(@(x)h(x,ue,0),xe);
    
end